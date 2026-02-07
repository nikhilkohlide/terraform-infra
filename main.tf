module "vpc" {
  source = "./modules/vpc"

  project_name    = var.project_name
  aws_region      = var.aws_region
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}
module "compute" {
  source = "./modules/compute"

  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id
  public_subnets   = module.vpc.public_subnets
  private_subnets  = module.vpc.private_subnets
  instance_type    = var.instance_type
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

