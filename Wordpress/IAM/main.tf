resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "ecs_exec_ssm_policy" {
  name   = "ECSExecSSMPermissions"
  path   = "/"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect : "Allow",
        Action : [
          "ssm:StartSession",
          "ssm:DescribeDocument",
          "ssm:SendCommand"
        ],
        Resource : "*"
      }
    ]
  })
}

# Attach Custom SSM Policy to ECS Execution Role
resource "aws_iam_role_policy_attachment" "ecs_exec_ssm_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_exec_ssm_policy.arn
}