variable "aws_region" {
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "alb_name" {
  description = "Name of the ALB"
  default = "Wordpress-ALB"
}

variable "cluster_name" {
  default = "Wordpress-cluster"
}

variable "service_name" {
  default = "Wordpress-service"
}

