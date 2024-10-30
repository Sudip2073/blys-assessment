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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_assoc" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_route_table.id
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