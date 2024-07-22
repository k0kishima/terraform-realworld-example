variable "env" {
  description = "The environment (e.g., prod, staging, dev)"
  type        = string

  validation {
    condition     = contains(["prod", "staging", "dev"], var.env)
    error_message = "The 'env' variable must be one of 'prod', 'staging', or 'dev'."
  }
}

variable "project" {
  description = "The project name"
  default     = "realworld-example"
}

variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster and tasks will be deployed"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs for the ECS tasks"
  type        = list(string)
}

variable "alb_security_group" {
  description = "The ID of the security group associated with the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group for the ECS service"
  type        = string
}
