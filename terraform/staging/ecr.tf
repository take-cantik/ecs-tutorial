# ------------------
# ECR
# ------------------

# ECR reoisitory for web
resource "aws_ecr_repository" "web" {
  name = "${var.project_name}-${var.environment}-web"
}

resource "aws_ecr_lifecycle_policy" "web" {
  repository = aws_ecr_repository.web.name

  policy = jsonencode(
    {
      rules = [
        {
          rulePriority = 1,
          description  = "Keep last 10 images",
          selection = {
            tagStatus   = "any",
            countType   = "imageCountMoreThan",
            countNumber = 10,
          },
          action = {
            type = "expire",
          },
        }
      ]
    }
  )
}

# ECR reoisitory for backend
resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-${var.environment}-backend"
}

resource "aws_ecr_lifecycle_policy" "backend" {
  repository = aws_ecr_repository.backend.name

  policy = jsonencode(
    {
      rules = [
        {
          rulePriority = 1,
          description  = "Keep last 10 images",
          selection = {
            tagStatus   = "any",
            countType   = "imageCountMoreThan",
            countNumber = 10,
          },
          action = {
            type = "expire",
          },
        }
      ]
    }
  )
}

# ECR reoisitory for frontend
resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend"
}

resource "aws_ecr_lifecycle_policy" "frontend" {
  repository = aws_ecr_repository.frontend.name

  policy = jsonencode(
    {
      rules = [
        {
          rulePriority = 1,
          description  = "Keep last 10 images",
          selection = {
            tagStatus   = "any",
            countType   = "imageCountMoreThan",
            countNumber = 10,
          },
          action = {
            type = "expire",
          },
        }
      ]
    }
  )
}
