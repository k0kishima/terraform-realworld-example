output "alb_security_group_id" {
  description = "The ID of the security group associated with the ALB"
  value       = aws_security_group.alb.id
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group associated with the load balancer"
  value       = aws_lb_target_group.tg.arn
}
