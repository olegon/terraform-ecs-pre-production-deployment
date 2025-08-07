resource "aws_lb" "pre_production" {
  name               = "pre-production"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.pre_production.id]
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "pre_production_http_prod" {
  load_balancer_arn = aws_lb.pre_production.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = 404
      message_body = "Not found on Pre-Prod-ELB (80)."
    }
  }
}

resource "aws_lb_listener" "pre_production_http_test" {
  load_balancer_arn = aws_lb.pre_production.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = 404
      message_body = "Not found on Pre-Prod-ELB (8080)."
    }
  }
}
