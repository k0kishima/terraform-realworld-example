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

resource "aws_ecr_repository" "frontend_app" {
  name                 = "${var.project}-${var.env}-frontend-app-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-frontend-app-ecr-repo"
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


resource "aws_ecr_repository" "backend_app" {
  name                 = "${var.project}-${var.env}-backend-app-ecr-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-backend-app-ecr-repo"
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

resource "aws_ecr_lifecycle_policy" "frontend_app" {
  repository = aws_ecr_repository.frontend_app.name

  policy = jsonencode(local.lifecycle_policy)
}

resource "aws_ecr_lifecycle_policy" "backend_proxy" {
  repository = aws_ecr_repository.backend_proxy.name

  policy = jsonencode(local.lifecycle_policy)
}

resource "aws_ecr_lifecycle_policy" "backend_app" {
  repository = aws_ecr_repository.backend_app.name

  policy = jsonencode(local.lifecycle_policy)
}
