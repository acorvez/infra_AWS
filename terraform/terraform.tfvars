aws_region = "eu-west-1"
project_name = "platform"
environment = "dev"

vpc_cidr = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
availability_zones = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]

eks_desired_size = 3
eks_max_size = 6
eks_min_size = 2
eks_instance_types = ["t3.large"]

certificate_arn = "arn:aws:acm:eu-west-1:123456789012:certificate/abcdef-1234-5678-abcd-1234567890ab"

vpn_client_cidr = "172.16.0.0/22"

rds_allocated_storage = 20
rds_storage_type = "gp3"
rds_engine = "postgres"
rds_engine_version = "15.3"
rds_instance_class = "db.t3.medium"
rds_db_name = "platform"
rds_username = "admin"
rds_password = "Chang3M3N0w!"  # À remplacer par un mot de passe sécurisé

ec2_instance_type = "t3.medium"
keycloak_version = "22.0.5"