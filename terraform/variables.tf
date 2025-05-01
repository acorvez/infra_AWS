variable "aws_region" {
  description = "Région AWS pour le déploiement"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "platform"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR du VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Liste des CIDRs pour les sous-réseaux publics"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Liste des CIDRs pour les sous-réseaux privés"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}

variable "availability_zones" {
  description = "Liste des zones de disponibilité"
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "eks_desired_size" {
  description = "Nombre désiré de nœuds pour EKS"
  type        = number
  default     = 3
}

variable "eks_max_size" {
  description = "Nombre maximal de nœuds pour EKS"
  type        = number
  default     = 6
}

variable "eks_min_size" {
  description = "Nombre minimal de nœuds pour EKS"
  type        = number
  default     = 2
}

variable "eks_instance_types" {
  description = "Types d'instances pour les nœuds EKS"
  type        = list(string)
  default     = ["t3.large"]
}

variable "certificate_arn" {
  description = "ARN du certificat SSL pour l'ALB"
  type        = string
  default     = ""
}

variable "vpn_client_cidr" {
  description = "CIDR pour les clients VPN"
  type        = string
  default     = "172.16.0.0/22"
}

variable "rds_allocated_storage" {
  description = "Stockage alloué pour RDS (Go)"
  type        = number
  default     = 20
}

variable "rds_storage_type" {
  description = "Type de stockage pour RDS"
  type        = string
  default     = "gp3"
}

variable "rds_engine" {
  description = "Moteur de base de données pour RDS"
  type        = string
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "Version du moteur de base de données pour RDS"
  type        = string
  default     = "15.3"
}

variable "rds_instance_class" {
  description = "Classe d'instance pour RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "rds_db_name" {
  description = "Nom de la base de données"
  type        = string
  default     = "platform"
}

variable "rds_username" {
  description = "Nom d'utilisateur pour RDS"
  type        = string
  default     = "admin"
}

variable "rds_password" {
  description = "Mot de passe pour RDS"
  type        = string
  sensitive   = true
}

variable "ec2_instance_type" {
  description = "Type d'instance EC2 pour les services annexes"
  type        = string
  default     = "t3.medium"
}

variable "keycloak_version" {
  description = "Version de Keycloak"
  type        = string
  default     = "22.0.5"
}
