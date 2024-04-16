resource "aws_codebuild_project" "frontend_build" {
  name          = "${var.project}-${var.env}-frontend-app-build"
  description   = "Build project for the Nuxt3 application"
  build_timeout = 60 # minutes as integer

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "NODE_ENV"
      value = "production"
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "ap-northeast-1"
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.frontend_ecr_name
    }
    environment_variable {
      name  = "IMAGE_TAG"
      value = "latest"
    }
  }

  source {
    type            = "GITHUB"
    location        = var.repo_url
    git_clone_depth = 1
  }

  service_role = aws_iam_role.codebuild_role.arn

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-codebuild"
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-nuxt3-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-codebuild-role"
  }
}
