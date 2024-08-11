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
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the RDS cluster"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs"
  type        = list(string)
}

variable "database_name" {
  description = "The name of the database"
  type        = string
  default     = "golang_realworld"
}

variable "master_username" {
  description = "The master username for the database"
  type        = string
}

variable "db_master_password" {
  description = "The master password for the database"
  type        = string
  sensitive   = true
}
