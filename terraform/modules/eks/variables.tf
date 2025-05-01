variable "cluster_name" {
  description = "Nom du cluster EKS"
  type        = string
}

variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs des sous-réseaux pour le cluster EKS"
  type        = list(string)
}

variable "node_group_name" {
  description = "Nom du groupe de nœuds EKS"
  type        = string
}

variable "desired_size" {
  description = "Nombre désiré de nœuds pour EKS"
  type        = number
  default     = 3
}

variable "max_size" {
  description = "Nombre maximal de nœuds pour EKS"
  type        = number
  default     = 5
}

variable "min_size" {
  description = "Nombre minimal de nœuds pour EKS"
  type        = number
  default     = 1
}

variable "instance_types" {
  description = "Types d'instances pour les nœuds EKS"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "ssh_key_name" {
  description = "Nom de la clé SSH pour l'accès aux nœuds"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "Liste des IDs de groupes de sécurité à associer au cluster EKS"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "Région AWS"
  type        = string
  default     = "eu-west-1"
}
