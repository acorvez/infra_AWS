resource "aws_efs_file_system" "main" {
  creation_token = "${var.project_name}-${var.environment}-efs"
  encrypted      = true
  
  performance_mode = var.performance_mode
  throughput_mode  = var.throughput_mode
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-efs"
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}

resource "aws_efs_mount_target" "main" {
  count           = length(var.subnet_ids)
  file_system_id  = aws_efs_file_system.main.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = var.security_groups
}

resource "aws_efs_access_point" "main" {
  file_system_id = aws_efs_file_system.main.id
  
  posix_user {
    gid = 1000
    uid = 1000
  }
  
  root_directory {
    path = "/data"
    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = "755"
    }
  }
  
  tags = {
    Name        = "${var.project_name}-${var.environment}-efs-ap"
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}

# Politique de sauvegarde EFS
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.main.id

  backup_policy {
    status = "ENABLED"
  }
}