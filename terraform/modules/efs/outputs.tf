output "efs_id" {
  description = "ID du système de fichiers EFS"
  value       = aws_efs_file_system.main.id
}

output "efs_arn" {
  description = "ARN du système de fichiers EFS"
  value       = aws_efs_file_system.main.arn
}

output "efs_dns_name" {
  description = "Nom DNS du système de fichiers EFS"
  value       = aws_efs_file_system.main.dns_name
}

output "mount_targets" {
  description = "IDs des points de montage EFS"
  value       = aws_efs_mount_target.main[*].id
}

output "access_point_id" {
  description = "ID du point d'accès EFS"
  value       = aws_efs_access_point.main.id
}

output "access_point_arn" {
  description = "ARN du point d'accès EFS"
  value       = aws_efs_access_point.main.arn
}