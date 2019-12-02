resource "aws_security_group" "ecs-security-group" {
  name = "ecs"
  vpc_id = aws_vpc.main.id
  description = "Security group for ecs"
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ecs sec"
  }
}