output "alb_security_group_id" {
  description = "The ID of the security group associated with the ALB"
  value       = aws_security_group.alb.id
}

output "frontend_target_group_arn" {
  description = "The ARN of the target group associated with the load balancer for frontend"
  value       = aws_lb_target_group.frontend.arn
}

output "backend_target_group_arn" {
  description = "The ARN of the target group associated with the load balancer for backend"
  value       = aws_lb_target_group.backend.arn
}

output "frontend_alb_dns_name" {
  description = "The DNS name of the Application Load Balancer for frontend"
  value       = aws_lb.frontend.dns_name
}

output "backend_alb_dns_name" {
  description = "The DNS name of the Application Load Balancer for backend"
  value       = aws_lb.backend.dns_name
}
