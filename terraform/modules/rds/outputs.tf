output "endpoint" {
  description = "Point de terminaison de l'instance RDS"
  value       = aws_db_instance.main.endpoint
}

output "address" {
  description = "Adresse de l'instance RDS"
  value       = aws_db_instance.main.address
}

output "port" {
  description = "Port de l'instance RDS"
  value       = aws_db_instance.main.port
}

output "arn" {
  description = "ARN de l'instance RDS"
  value       = aws_db_instance.main.arn
}

output "db_name" {
  description = "Nom de la base de données"
  value       = aws_db_instance.main.db_name
}

output "id" {
  description = "ID de l'instance RDS"
  value       = aws_db_instance.main.id
}