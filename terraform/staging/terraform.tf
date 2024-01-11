# ------------------
# Terraform
# ------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "ecs-tutorial-terraform-state"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
    dynamodb_table = "ecs-tutorial-terraform-state-lock"
  }
}
