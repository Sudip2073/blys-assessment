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
  launch_type     = "FARGATE" 

  network_configuration {
    subnets = var.public_subnets
    security_groups  = [var.ecs_security_group]
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
  network_mode             = "awsvpc" 
  requires_compatibilities = ["FARGATE"] 
  cpu                      = "256"  
  memory                   = "512"  

  execution_role_arn      = var.ecs_task_execution_role_arn
  container_definitions = file("${path.module}/template.json")
  
  volume {
    name      = "db_data"
  }

  tags = {
    Name = "wordpress-task"
  }
}

