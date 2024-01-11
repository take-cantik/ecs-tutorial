# ------------------
# Variables
# ------------------
variable "aws_region" {
  type = string
  default = "ap-northeast-1"
  description = "AWS region to deploy to"
}

variable "project_name" {
  type = string
  default = "ecs-tutorial"
  description = "Project name"
}

variable "environment" {
  type = string
  default = "staging"
  description = "Environment"
}

variable "az_a" {
  type = string
  default = "ap-northeast-1a"
  description = "Availability Zone A"
}

variable "az_c" {
  type = string
  default = "ap-northeast-1c"
  description = "Availability Zone C"
}
