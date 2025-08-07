# Blue

resource "aws_lb_listener" "nlb_pre_production_http_prod" {
  count = local.is_nlb_attachment ? 1 : 0

  load_balancer_arn = data.aws_lb.lb_ingress.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_ingress_app_blue[0].arn
  }
}

resource "aws_lb_target_group" "nlb_ingress_app_blue" {
  count = local.is_nlb_attachment ? 1 : 0

  name        = format("%s-blue", var.app_name)
  port        = var.app_docker_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    enabled = true

    healthy_threshold   = 2
    interval            = 10
    port                = "traffic-port"
    protocol            = "TCP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  deregistration_delay = 60
}



# Green

resource "aws_lb_listener" "nlb_pre_production_http_test" {
  count = local.is_nlb_attachment ? 1 : 0

  load_balancer_arn = data.aws_lb.lb_ingress.arn
  port              = 8080
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_ingress_app_green[0].arn
  }
}

resource "aws_lb_target_group" "nlb_ingress_app_green" {
  count = local.is_nlb_attachment ? 1 : 0

  name        = format("%s-green", var.app_name)
  port        = var.app_docker_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    enabled = true

    healthy_threshold   = 2
    interval            = 10
    port                = "traffic-port"
    protocol            = "TCP"
    timeout             = 5
    unhealthy_threshold = 5
  }

  deregistration_delay = 60
}