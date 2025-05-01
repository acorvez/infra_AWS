resource "aws_db_subnet_group" "main" {
  name       = "${var.identifier}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.identifier}-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier             = var.identifier
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]
  parameter_group_name   = aws_db_parameter_group.main.name
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = var.multi_az
  backup_retention_period = var.backup_retention_period
  storage_encrypted       = true

  tags = {
    Name = var.identifier
  }
}

resource "aws_db_parameter_group" "main" {
  name   = "${var.identifier}-params"
  family = var.engine == "postgres" ? "postgres15" : "mysql8.0"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name  = parameter.key
      value = parameter.value
    }
  }

  tags = {
    Name = "${var.identifier}-params"
  }
}