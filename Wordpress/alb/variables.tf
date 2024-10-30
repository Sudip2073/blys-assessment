variable "alb_name" {
  description = "Name of the ALB"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "alb_security_group" {
  description = "Security group of the VPC"
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}


