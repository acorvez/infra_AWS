variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
}

variable "public_subnets" {
  description = "Liste des CIDRs pour les sous-réseaux publics"
  type        = list(string)
}

variable "private_subnets" {
  description = "Liste des CIDRs pour les sous-réseaux privés"
  type        = list(string)
}

variable "azs" {
  description = "Liste des zones de disponibilité"
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
