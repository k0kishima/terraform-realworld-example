output "codebuild_project_name" {
  value       = aws_codebuild_project.nuxt_build.name
  description = "The name of the CodeBuild project"
}

output "codebuild_project_arn" {
  value       = aws_codebuild_project.nuxt_build.arn
  description = "The ARN of the CodeBuild project"
}
