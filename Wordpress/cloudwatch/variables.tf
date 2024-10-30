variable "cluster_name" {
  description = "Name of the ECS cluster"
}

variable "service_name" {
  description = "Name of the ECS service"
}

variable "notification_email" {
  description = "Email address for SNS notifications"
  type        = string
}