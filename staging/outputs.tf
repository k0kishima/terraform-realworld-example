output "aurora_cluster_endpoint" {
  description = "The endpoint of the Aurora cluster"
  value       = module.database.aurora_cluster_endpoint
}

output "aurora_cluster_reader_endpoint" {
  description = "The reader endpoint of the Aurora cluster"
  value       = module.database.aurora_cluster_reader_endpoint
}

output "frontend_alb_dns_name" {
  description = "The DNS name of the Application Load Balancer for frontend"
  value       = module.alb.frontend_alb_dns_name
}

output "backend_alb_dns_name" {
  description = "The DNS name of the Application Load Balancer for backend"
  value       = module.alb.backend_alb_dns_name
}
