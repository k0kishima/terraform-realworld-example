resource "aws_codebuild_project" "nuxt_build" {
  name          = "nuxt3-app-build"
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
      value = aws_ecr_repository.nuxt_app.name
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
    Name    = "${var.project}-${var.env}-CodeBuild"
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
    Name    = "${var.project}-${var.env}-CodeBuild-Role"
  }
}

resource "aws_iam_policy" "codebuild_policy" {
  name   = "codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild_policy_attachment" {
  role       = aws_iam_role.codebuild_role.id
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

resource "aws_ecr_repository" "nuxt_app" {
  name                 = "${var.project}-${var.env}-nuxt-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Env     = var.env
    Project = var.project
  }
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = [aws_ecr_repository.nuxt_app.arn]
    effect    = "Allow"
  }

  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"]
    effect    = "Allow"
  }
}
