# ------------------
# AWS
# ------------------
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      "Project" = "ecs-tutorial"
      "Environment" = "staging"
    }
  }
}
