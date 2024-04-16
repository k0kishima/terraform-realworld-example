output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "iam_user_name" {
  description = "The name of the IAM user for CodeBuild access"
  value       = module.iam.github_actions_user_name
}
