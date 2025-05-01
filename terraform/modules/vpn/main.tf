# Certificat CA pour le serveur Client VPN
resource "aws_acm_certificate" "vpn_server" {
  private_key       = file("${path.module}/certs/server.key")
  certificate_body  = file("${path.module}/certs/server.crt")
  certificate_chain = file("${path.module}/certs/ca.crt")
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-vpn-cert"
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}

# Point de terminaison Client VPN
resource "aws_ec2_client_vpn_endpoint" "main" {
  description            = "${var.project_name}-${var.environment}-client-vpn"
  server_certificate_arn = aws_acm_certificate.vpn_server.arn
  client_cidr_block      = var.client_cidr
  split_tunnel           = var.split_tunnel
  
  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.vpn_server.arn
  }
  
  connection_log_options {
    enabled               = false
    cloudwatch_log_group  = null
    cloudwatch_log_stream = null
  }
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-client-vpn"
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}

# Association de sous-réseau Client VPN
resource "aws_ec2_client_vpn_network_association" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  subnet_id              = var.public_subnet_id
  security_groups        = [var.security_group]
}

# Règle d'autorisation pour tous les utilisateurs
resource "aws_ec2_client_vpn_authorization_rule" "main" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  target_network_cidr    = "0.0.0.0/0"
  authorize_all_groups   = true
}

# Route pour accéder à Internet
resource "aws_ec2_client_vpn_route" "internet" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  destination_cidr_block = "0.0.0.0/0"
  target_vpc_subnet_id   = var.public_subnet_id
  
  depends_on = [aws_ec2_client_vpn_network_association.main]
}