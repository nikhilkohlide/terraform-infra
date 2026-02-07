output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}

output "app_sg_id" {
  value = aws_security_group.app_sg.id
}
output "asg_name" {
  value = aws_autoscaling_group.this.name
}
output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

