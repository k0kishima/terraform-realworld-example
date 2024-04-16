output "frontend_arn" {
  description = "ARN of the frontend ECR repository"
  value       = aws_ecr_repository.frontend.arn
}

output "frontend_name" {
  description = "Name of the frontend ECR repository"
  value       = aws_ecr_repository.frontend.name
}

output "frontend_repository_url" {
  description = "The repository URL for the frontend application"
  value       = aws_ecr_repository.frontend.repository_url
}
