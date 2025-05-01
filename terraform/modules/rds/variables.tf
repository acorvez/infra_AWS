variable "identifier" {
  description = "Identifiant pour l'instance RDS"
  type        = string
}

variable "allocated_storage" {
  description = "Stockage alloué en gigaoctets"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Type de stockage (gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "engine" {
  description = "Moteur de base de données (mysql, postgres)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Version du moteur de base de données"
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  description = "Classe d'instance pour RDS"
  type        = string
  default     = "db.t3.medium"
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
}

variable "db_username" {
  description = "Nom d'utilisateur pour la base de données"
  type        = string
}

variable "db_password" {
  description = "Mot de passe pour la base de données"
  type        = string
  sensitive   = true
}

variable "subnet_ids" {
  description = "Liste des IDs de sous-réseaux"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du groupe de sécurité pour RDS"
  type        = string
}

variable "multi_az" {
  description = "Si true, l'instance RDS sera déployée dans plusieurs zones de disponibilité"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Jours de rétention des sauvegardes"
  type        = number
  default     = 7
}

variable "db_parameters" {
  description = "Paramètres personnalisés pour la base de données"
  type        = map(string)
  default     = {}
}