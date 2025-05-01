variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs des sous-réseaux pour les points de montage EFS"
  type        = list(string)
}

variable "security_groups" {
  description = "Liste des IDs de groupes de sécurité pour les points de montage EFS"
  type        = list(string)
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
}

variable "performance_mode" {
  description = "Mode de performance EFS (generalPurpose ou maxIO)"
  type        = string
  default     = "generalPurpose"
}

variable "throughput_mode" {
  description = "Mode de débit EFS (bursting, provisioned, ou elastic)"
  type        = string
  default     = "bursting"
}