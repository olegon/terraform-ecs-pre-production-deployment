resource "aws_lb" "production_reverse_proxy" {
  name               = "production-reverse-proxy"
  internal           = false
  load_balancer_type = "network"
  security_groups    = [aws_security_group.production_reverse_proxy.id]
  subnets            = data.aws_subnets.default.ids

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
}