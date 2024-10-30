resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name                = "${var.cluster_name}-high-cpu"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name              = "CPUUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60"  
  statistic                 = "Average"
  threshold                 = "80"  
  alarm_description         = "This alarm monitors high CPU usage in the ECS service."
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [var.notification_topic_arn]  
  ok_actions    = [var.notification_topic_arn]  
}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name                = "${var.cluster_name}-high-memory"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name              = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  period                    = "60" 
  statistic                 = "Average"
  threshold                 = "80"  
  alarm_description         = "This alarm monitors high memory usage in the ECS service."
  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [var.notification_topic_arn] 
  ok_actions    = [var.notification_topic_arn]  
}