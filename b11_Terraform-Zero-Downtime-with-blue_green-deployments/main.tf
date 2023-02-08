provider "aws" {
  region = "us-east-2"
}

variable "production" {
  default = "green" //change here
}

module "base" {
  source     = "terraform-in-action/aws/bluegreen//modules/base"
  production = var.production
}

module "green" {
  source      = "terraform-in-action/aws/bluegreen//modules/autoscaling"
  app_version = "v1.0"
  label       = "green"
  base        = module.base
  instance_type = "t2.micro"
  default_vcpus = 1
}


module "blue" {
  source      = "terraform-in-action/aws/bluegreen//modules/autoscaling"
  app_version = "v2.0"
  label       = "blue"
  base        = module.base
  instance_type = "t2.micro"
  default_vcpus = 1
}

output "lb_dns_name" {
  value = module.base.lb_dns_name
}
