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

variable "repo_url" {
  default     = "https://github.com/k0kishima/nuxt3-realworld-example-app.git"
  type        = string
  description = "The URL of the GitHub repository"
}
