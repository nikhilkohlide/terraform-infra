output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_sg_id" {
  value = module.compute.alb_sg_id
}

output "app_sg_id" {
  value = module.compute.app_sg_id
}
output "alb_dns_name" {
  value = module.compute.alb_dns_name
}

