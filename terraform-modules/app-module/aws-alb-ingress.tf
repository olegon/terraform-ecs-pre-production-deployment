# Blue

data "aws_lb_listener" "lb_ingress_http_prod" {
  count = local.is_alb_attachment ? 1 : 0

  load_balancer_arn = data.aws_lb.lb_ingress.arn
  port              = 80
}

resource "aws_lb_listener_rule" "alb_ingress_http_prod_app" {
  count = local.is_alb_attachment ? 1 : 0

  listener_arn = data.aws_lb_listener.lb_ingress_http_prod[0].arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ingress_app_blue[0].arn
  }

  condition {
    host_header {
      values = [var.load_balancer_host_rule]
    }
  }

  # When Blue Green is active, Code Deploy will change traffic between Blue and Green Target Groups.
  lifecycle {
    ignore_changes = [
      action
    ]
  }
}

resource "aws_lb_target_group" "alb_ingress_app_blue" {
  count = local.is_alb_attachment ? 1 : 0

  name        = format("%s-blue", var.app_name)
  port        = var.app_docker_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    enabled = true

    healthy_threshold   = 2
    interval            = 10
    matcher             = "200-299"
    path                = var.app_health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  deregistration_delay = 60
}



# Green

data "aws_lb_listener" "lb_ingress_http_test" {
  count = local.is_alb_attachment ? 1 : 0

  load_balancer_arn = data.aws_lb.lb_ingress.arn
  port              = 8080
}

resource "aws_lb_listener_rule" "lb_ingress_http_test_app" {
  count = local.is_alb_attachment ? 1 : 0

  listener_arn = data.aws_lb_listener.lb_ingress_http_test[0].arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_ingress_app_green[0].arn
  }

  condition {
    host_header {
      values = [var.load_balancer_host_rule]
    }
  }

  # When Blue Green is active, Code Deploy will change traffic between Blue and Green Target Groups.
  lifecycle {
    ignore_changes = [
      action
    ]
  }
}

resource "aws_lb_target_group" "alb_ingress_app_green" {
  count = local.is_alb_attachment ? 1 : 0

  name        = format("%s-green", var.app_name)
  port        = var.app_docker_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    enabled = true

    healthy_threshold   = 2
    interval            = 10
    matcher             = "200-299"
    path                = var.app_health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  deregistration_delay = 60
}
