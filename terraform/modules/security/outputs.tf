output "eks_sg_id" {
  description = "ID du groupe de sécurité du cluster EKS"
  value       = aws_security_group.eks_cluster.id
}

output "alb_sg_id" {
  description = "ID du groupe de sécurité de l'ALB"
  value       = aws_security_group.alb.id
}

output "vpn_sg_id" {
  description = "ID du groupe de sécurité du VPN"
  value       = aws_security_group.vpn.id
}

output "rds_sg_id" {
  description = "ID du groupe de sécurité de RDS"
  value       = aws_security_group.rds.id
}

output "efs_sg_id" {
  description = "ID du groupe de sécurité d'EFS"
  value       = aws_security_group.efs.id
}
