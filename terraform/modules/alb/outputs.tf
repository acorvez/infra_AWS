output "dns_name" {
  description = "Nom DNS de l'ALB"
  value       = aws_lb.main.dns_name
}

output "zone_id" {
  description = "Zone ID de l'ALB"
  value       = aws_lb.main.zone_id
}

output "arn" {
  description = "ARN de l'ALB"
  value       = aws_lb.main.arn
}

output "id" {
  description = "ID de l'ALB"
  value       = aws_lb.main.id
}

output "https_listener_arn" {
  description = "ARN du listener HTTPS"
  value       = aws_lb_listener.https.arn
}

output "target_group_arns" {
  description = "ARNs des groupes cibles"
  value       = aws_lb_target_group.main[*].arn
}

output "listener_rules" {
  description = "IDs des règles de listener"
  value       = aws_lb_listener_rule.main[*].id
}