output "cluster_endpoint" {
  description = "Endpoint du cluster EKS"
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_name" {
  description = "Nom du cluster EKS"
  value       = aws_eks_cluster.main.name
}

output "cluster_ca_certificate" {
  description = "Certificat CA du cluster EKS"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "URL du fournisseur d'identité OIDC du cluster EKS"
  value       = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

output "node_group_arn" {
  description = "ARN du groupe de nœuds EKS"
  value       = aws_eks_node_group.main.arn
}

output "node_group_id" {
  description = "ID du groupe de nœuds EKS"
  value       = aws_eks_node_group.main.id
}

output "node_group_status" {
  description = "Statut du groupe de nœuds EKS"
  value       = aws_eks_node_group.main.status
}
