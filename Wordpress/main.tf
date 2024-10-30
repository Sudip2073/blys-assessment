module "vpc" {
  source = "./vpc"
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "alb" {
  source = "./alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_name = var.alb_name
  alb_security_group  = module.vpc.aws_security_group
}

module "ecs" {
  source = "./ecs"
  cluster_name = var.cluster_name
  service_name = var.service_name
  alb_target_group_arn = module.alb.target_group_arn
  # vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
}

module "cloudwatch" {
  source = "./cloudwatch"
  cluster_name = var.cluster_name
  service_name = var.service_name
  notification_email = var.notification_email
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "public_subnets_from_vpc" {
  description = "Public subnets from the VPC module"
  value       = module.vpc.public_subnets
}