variable "cluster_name" {
  description = "Name of the ECS cluster"
}

variable "service_name" {
  description = "Name of the ECS service"
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ARN of the ALB target group"
}

variable "desired_count" {
  default = "2"
}

variable "ecs_security_group" {
  description = "Security group for the ECS service"
  type        = string
}