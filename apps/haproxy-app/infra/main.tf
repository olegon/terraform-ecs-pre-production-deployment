terraform {
  backend "s3" {
    bucket         = "105029661252-terraform-backend"
    key            = "github/terraform-ecs-pre-production-deployment/haproxy-app.tfstate"
    dynamodb_table = "105029661252-terraform-backend"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

module "infra" {
  source = "../../../terraform-modules/app-module"

  app_docker_image      = "105029661252.dkr.ecr.sa-east-1.amazonaws.com/haproxy-app:v1"
  app_docker_port       = 8080
  app_health_check_path = "/haproxy-health"
  app_name              = "haproxy-app"

  app_environment_variables = {
    "PRIMARY_BACKEND"   = "node-app.elb-production.olegon-private.com:80"
    "SECONDARY_BACKEND" = "node-app.elb-pre-production.olegon-private.com:80"
  }

  ecs_cluster_name = "my-ecs-cluster-production-reverse-proxy"

  deployment_type               = "Blue Green"
  deployment_bluegreen_strategy = "CodeDeployDefault.ECSAllAtOnce"

  origin_security_group_name = "production-reverse-proxy"
  load_balancer_name         = "production-reverse-proxy"
}
