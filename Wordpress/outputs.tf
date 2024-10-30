output "wordpress_alb_dns" {
  description = "The DNS name of the ALB for WordPress"
  value       = module.alb.alb_dns_name
}
