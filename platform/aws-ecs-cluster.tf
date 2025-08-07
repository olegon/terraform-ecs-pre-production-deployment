resource "aws_ecs_cluster" "production_reverse_proxy" {
  name = "${var.ecs_cluster_name}-production-reverse-proxy"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster" "pre_production" {
  name = "${var.ecs_cluster_name}-pre-production"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster" "production" {
  name = "${var.ecs_cluster_name}-production"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
