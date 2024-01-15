# -----------------------
# ALB
# -----------------------
resource "aws_lb" "main" {
  name                       = "${var.project_name}-${var.environment}-lb"
  load_balancer_type         = "application"
  internal                   = false
  enable_deletion_protection = true

  security_groups            = [aws_security_group.alb.id]
  subnets                    = module.vpc.public_subnets

  tags = {
    Name = "${var.project_name}-${var.environment}-lb"
  }
}

# Listner
resource "aws_lb_listener" "main_http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = 200
      message_body = "ok"
    }
  }
}

# TODO: ACMを発行したら追加
# resource "aws_lb_listener" "main_http_to_https" {
#   load_balancer_arn = aws_lb.main.arn
#   port              = 80
#   protocol          = "HTTP"
#
#   default_action {
#     type             = "redirect"
#     redirect {
#       port         = "443"
#       protocol     = "HTTPS"
#       status_code  = "HTTP_301"
#     }
#   }
# }
#
# resource "aws_lb_listener" "main_https" {
#   load_balancer_arn = aws_lb.main.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#
#   default_action {
#     type             = "fixed-response"
#
#     fixed_response {
#       content_type = "text/plain"
#       status_code  = 200
#       message_body = "ok"
#     }
#   }
# }

# Target Group
resource "aws_lb_target_group" "web" {
  name     = "${var.project_name}-${var.environment}-web"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/api/health-check"
    matcher             = 200
    interval            = 60
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-web"
  }
}

resource "aws_lb_target_group" "frontend" {
  name     = "${var.project_name}-${var.environment}-frontend"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    matcher             = 200
    interval            = 60
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-frontend"
  }
}

# Listener rule
resource "aws_lb_listener_rule" "web" {
  listener_arn = aws_lb_listener.main_http.arn
  priority     = 1

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}

resource "aws_lb_listener_rule" "frontend" {
  listener_arn = aws_lb_listener.main_http.arn
  priority     = 3

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend.arn
  }
}

