resource "aws_db_instance" "default" {
  identifier = "${var.project_name}-${var.environment}-db"
  engine = "postgres"
  engine_version = "15.5"
  port = 5432
  multi_az = false
  instance_class = "db.t3.micro"
  storage_type = "gp2"
  allocated_storage = 5
  db_name = "ecsTutorial"
  username = data.aws_ssm_parameter.rds_username.value
  password = data.aws_ssm_parameter.rds_password.value
  db_subnet_group_name = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-db"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}
