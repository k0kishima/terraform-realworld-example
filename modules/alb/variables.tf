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
  description = "The ID of the VPC where the ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet IDs for the ALB"
  type        = list(string)
}

variable "listener_port" {
  description = "The port on which the ALB listens"
  type        = number
  default     = 80
}

variable "target_group_path" {
  description = "The path for the target group health check"
  type        = string
  default     = "/"
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}
