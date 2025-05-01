variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID du sous-réseau public pour le point de terminaison VPN"
  type        = string
}

variable "security_group" {
  description = "ID du groupe de sécurité pour le point de terminaison VPN"
  type        = string
}

variable "client_cidr" {
  description = "CIDR pour les clients VPN"
  type        = string
  default     = "172.16.0.0/22"
}

variable "split_tunnel" {
  description = "Activer le tunneling partagé"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
}