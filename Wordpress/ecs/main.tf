resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Name = var.cluster_name
  }
}

resource "aws_ecs_service" "wordpress" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.wordpress.arn
  desired_count   = var.desired_count
  
  network_configuration {
    subnets = var.public_subnets
    assign_public_ip = true
  }
  
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "wordpress"
    container_port   = 80
  }
}

resource "aws_ecs_task_definition" "wordpress" {
  family                   = "wordpress"
  network_mode             = "awsvpc"  # Use awsvpc for ALB integration
  requires_compatibilities = ["FARGATE"]  # For Fargate launch type
  cpu                      = "256"  # CPU units
  memory                   = "512"  # Memory in MiB

  container_definitions = jsonencode([
    {
      name      = "wordpress"
      image     = "wordpress:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
      # environment = [
      #   {
      #     name  = "WORDPRESS_DB_HOST"
      #     value = "${var.wordPress_db_host}"
      #   },
      #   {
      #     name  = "WORDPRESS_DB_USER"
      #     value = "${var.wordPress_db_user}"
      #   },
      #   {
      #     name  = "WORDPRESS_DB_PASSWORD"
      #     value = "${var.wordPress_db_password}"
      #   },
      #   {
      #     name  = "WORDPRESS_DB_NAME"
      #     value = "${var.wordPress_db_name}"
      #   }
      # ]
    }
  ])

  tags = {
    Name = "wordpress-task"
  }
}

