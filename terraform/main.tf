provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
  
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

# Création du VPC et des sous-réseaux
module "vpc" {
  source = "./modules/vpc"
  
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  azs              = var.availability_zones
  project_name     = var.project_name
  environment      = var.environment
}

# Création des groupes de sécurité
module "security_groups" {
  source = "./modules/security"
  
  vpc_id         = module.vpc.vpc_id
  project_name   = var.project_name
  environment    = var.environment
}

# Déploiement d'EKS
module "eks" {
  source = "./modules/eks"
  
  cluster_name    = "${var.project_name}-${var.environment}-eks"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  node_group_name = "${var.project_name}-${var.environment}-node-group"
  desired_size    = var.eks_desired_size
  max_size        = var.eks_max_size
  min_size        = var.eks_min_size
  instance_types  = var.eks_instance_types
  security_groups = [module.security_groups.eks_sg_id]
}

# Déploiement de l'ALB
module "alb" {
  source = "./modules/alb"
  
  name             = "${var.project_name}-${var.environment}-alb"
  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnet_ids
  security_groups  = [module.security_groups.alb_sg_id]
  certificate_arn  = var.certificate_arn
}

# Déploiement du VPN
module "vpn" {
  source = "./modules/vpn"
  
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
  security_group   = module.security_groups.vpn_sg_id
  client_cidr      = var.vpn_client_cidr
  project_name     = var.project_name
  environment      = var.environment
}

# Déploiement de RDS
module "rds" {
  source = "./modules/rds"
  
  identifier        = "${var.project_name}-${var.environment}-db"
  allocated_storage = var.rds_allocated_storage
  storage_type      = var.rds_storage_type
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  db_name           = var.rds_db_name
  db_username       = var.rds_username
  db_password       = var.rds_password
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security_groups.rds_sg_id
}

# Déploiement d'EFS
module "efs" {
  source = "./modules/efs"
  
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  security_groups = [module.security_groups.efs_sg_id]
  project_name    = var.project_name
  environment     = var.environment
}

# Configuration des outputs pour les données nécessaires à Ansible
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "efs_id" {
  value = module.efs.efs_id
}

output "efs_dns_name" {
  value = module.efs.efs_dns_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
