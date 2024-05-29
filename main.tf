provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}

module "network" {
  source = "./modules/network"
}

module "compute" {
  source         = "./modules/compute"
  instance_count = 3
  subnet_id      = module.network.subnet_id
}

module "load_balancer" {
  source               = "./modules/load_balancer"
  instance_ids         = module.compute.instance_ids
  lb_security_group_id = module.network.lb_security_group_id
}



