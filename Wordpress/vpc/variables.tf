variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}
