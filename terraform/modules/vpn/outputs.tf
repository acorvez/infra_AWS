output "vpn_endpoint_id" {
  description = "ID du point de terminaison Client VPN"
  value       = aws_ec2_client_vpn_endpoint.main.id
}

output "vpn_endpoint_dns_name" {
  description = "Nom DNS du point de terminaison Client VPN"
  value       = aws_ec2_client_vpn_endpoint.main.dns_name
}

output "vpn_network_association_id" {
  description = "ID de l'association réseau Client VPN"
  value       = aws_ec2_client_vpn_network_association.main.id
}

output "vpn_route_id" {
  description = "ID de la route Client VPN"
  value       = aws_ec2_client_vpn_route.internet.id
}