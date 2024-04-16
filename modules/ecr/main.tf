resource "aws_ecr_repository" "frontend" {
  name                 = "${var.project}-${var.env}-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-frontend-ecr-repo"
  }
}
