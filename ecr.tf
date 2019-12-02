resource "aws_ecr_repository" "my_worker" {
  name = "my_worker"
}

output "worker-url" {
  value = aws_ecr_repository.my_worker.repository_url
}
