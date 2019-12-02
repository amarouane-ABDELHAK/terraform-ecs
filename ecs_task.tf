resource "aws_ecs_task_definition" "myapp" {
  family                   = "app"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecsTaskExcutionRole.arn
  task_role_arn            = aws_iam_role.ecs_task_assume.arn
  container_definitions    = <<DEFINITION
[
  {


    "image": "307493436926.dkr.ecr.us-west-2.amazonaws.com/my_worker:4",
    "name": "app",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "networkMode": "awsvpc",
    "workingDirectory": "/",
    "command": ["python", "entry_point.py"]
  }
]
DEFINITION
}

resource "aws_ecs_service" "main" {
  name            = "tf-ecs-service"
  cluster         = aws_ecs_cluster.fargate.name
  task_definition = aws_ecs_task_definition.myapp.arn
  desired_count   = "1"
  launch_type     = "FARGATE"
  network_configuration {
    subnets = aws_subnet.private.*.id
    security_groups = [aws_security_group.ecs-security-group.id]
  }

}