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

variable "github_repository" {
  type        = string
  description = "The GitHub repository in the format 'owner/repo', e.g., 'k0kishima/nuxt3-realworld-example-app'"
  default     = "k0kishima/nuxt3-realworld-example-app"
}
