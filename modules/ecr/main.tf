resource "aws_ecr_repository" "frontend_proxy" {
  name                 = "${var.project}-${var.env}-frontend-proxy-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-frontend-proxy-ecr-repo"
  }
}

resource "aws_ecr_repository" "frontend" {
  name                 = "${var.project}-${var.env}-frontend-ecr-repo"
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

resource "aws_ecr_repository" "backend_proxy" {
  name                 = "${var.project}-${var.env}-backend-proxy-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-backend-proxy-ecr-repo"
  }
}


resource "aws_ecr_repository" "backend" {
  name                 = "${var.project}-${var.env}-backend-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-backend-ecr-repo"
  }
}

locals {
  lifecycle_policy = {
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the last 5 images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 5
        }
        action = {
          type = "expire"
        }
      }
    ]
  }
}

resource "aws_ecr_lifecycle_policy" "frontend_proxy" {
  repository = aws_ecr_repository.frontend_proxy.name

  policy = jsonencode(local.lifecycle_policy)
}

resource "aws_ecr_lifecycle_policy" "frontend" {
  repository = aws_ecr_repository.frontend.name

  policy = jsonencode(local.lifecycle_policy)
}

resource "aws_ecr_lifecycle_policy" "backend_proxy" {
  repository = aws_ecr_repository.backend_proxy.name

  policy = jsonencode(local.lifecycle_policy)
}

resource "aws_ecr_lifecycle_policy" "backend" {
  repository = aws_ecr_repository.backend.name

  policy = jsonencode(local.lifecycle_policy)
}
