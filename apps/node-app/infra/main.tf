terraform {
  backend "s3" {
    bucket         = "105029661252-terraform-backend"
    key            = "github/terraform-ecs-pre-production-deployment/node-app.tfstate"
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


module "infra_production" {
  source = "../../../terraform-modules/app-module"

  app_docker_image      = "105029661252.dkr.ecr.sa-east-1.amazonaws.com/node-app-production:v1"
  app_docker_port       = 5000
  app_health_check_path = "/v1/health"
  app_name              = "node-app-production"
  app_environment_variables = {
    "PORT" = "5000"
  }

  deployment_type               = "Blue Green"
  deployment_bluegreen_strategy = "CodeDeployDefault.ECSAllAtOnce"

  ecs_cluster_name           = "my-ecs-cluster-production"
  origin_security_group_name = "production"
  load_balancer_name         = "production"
  load_balancer_host_rule    = "node-app.elb-production.olegon-private.com"
}

module "infra_pre_production" {
  source = "../../../terraform-modules/app-module"

  app_docker_image      = "105029661252.dkr.ecr.sa-east-1.amazonaws.com/node-app-pre-production:v1"
  app_docker_port       = 5000
  app_health_check_path = "/v1/health"
  app_name              = "node-app-pre-production"
  app_environment_variables = {
    "PORT" = "5000"
  }

  deployment_type               = "Blue Green"
  deployment_bluegreen_strategy = "CodeDeployDefault.ECSAllAtOnce"

  ecs_cluster_name           = "my-ecs-cluster-pre-production"
  origin_security_group_name = "pre-production"
  load_balancer_name         = "pre-production"
  load_balancer_host_rule    = "node-app.elb-pre-production.olegon-private.com"
}