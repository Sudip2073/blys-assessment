output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "aws_security_group" {
  value = aws_security_group.alb_sg.id
}

output "aws_security_group_container" {
  value = aws_security_group.container_sg.id
}
