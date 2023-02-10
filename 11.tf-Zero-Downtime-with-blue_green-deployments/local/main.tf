provider "aws" {
  region = "us-east-2"
}

variable "production" {
  default = "green" //change here
}

module "base" {
  source     = "./module/base"
  production = var.production
}

module "green" {
  source      = "./module/autoscaling"
  app_version = "v1.0"
  label       = "green"
  base        = module.base
}


module "blue" {
  source      = "./module/autoscaling"
  app_version = "v2.0"
  label       = "blue"
  base        = module.base
}

output "lb_dns_name" {
  value = module.base.lb_dns_name
}
