data "aws_ssm_parameter" "rds_username" {
  name = "/${var.project_name}/${var.environment}/rds/username"
}

data "aws_ssm_parameter" "rds_password" {
  name = "/${var.project_name}/${var.environment}/rds/password"
}
