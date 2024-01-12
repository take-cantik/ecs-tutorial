# -----------------------
# Security Group for ECS
# -----------------------
resource "aws_security_group" "ecs" {
  name = "${var.project_name}-${var.environment}-ecs"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "ecs_web" {
  security_group_id = aws_security_group.ecs.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ecs_frontend" {
  security_group_id = aws_security_group.ecs.id

  type = "ingress"

  from_port = 3000
  to_port   = 3000
  protocol  = "tcp"

  source_security_group_id = aws_security_group.alb.id
}


# -----------------------
# Security Group for ALB
# -----------------------
resource "aws_security_group" "alb" {
  name = "${var.project_name}-${var.environment}-alb"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

# -----------------------
# Security Group for RDS
# -----------------------
resource "aws_security_group" "rds" {
  name = "${var.project_name}-${var.environment}-rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

