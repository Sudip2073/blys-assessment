resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "wordpress-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr, 4, count.index)

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow inbound traffic for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb-sg"
  }
}