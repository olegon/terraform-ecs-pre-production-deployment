locals {
  is_alb_attachment = data.aws_lb.lb_ingress.load_balancer_type == "application"
  is_nlb_attachment = data.aws_lb.lb_ingress.load_balancer_type == "network"
}

data "aws_lb" "lb_ingress" {
  name = var.load_balancer_name
}