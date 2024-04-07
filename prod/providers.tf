provider "aws" {
  alias  = "primary"
  region = "ap-northeast-1"

  profile = var.profile_name
}
