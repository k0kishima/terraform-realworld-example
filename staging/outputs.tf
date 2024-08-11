output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "aurora_cluster_endpoint" {
  description = "The endpoint of the Aurora cluster"
  value       = module.database.aurora_cluster_endpoint
}

output "aurora_cluster_reader_endpoint" {
  description = "The reader endpoint of the Aurora cluster"
  value       = module.database.aurora_cluster_reader_endpoint
}
