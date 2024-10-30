resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group]
  subnets            = var.public_subnets
  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "main" {
  name     = "${var.alb_name}-tg"
  target_type = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30           
    timeout             = 5             
    healthy_threshold  = 2             
    unhealthy_threshold = 2             
    
  }

  tags = {
    Name = "${var.alb_name}-tg"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  depends_on = [
    aws_lb_target_group.main
  ]
}

resource "aws_lb_listener_rule" "path_based_routing" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100  

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  depends_on = [
    aws_lb_listener.http
  ]
}
