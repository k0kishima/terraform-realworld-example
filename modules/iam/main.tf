resource "aws_iam_user" "github_actions_user" {
  name = "${var.project}-${var.env}-github-actions-user"

  tags = {
    Project = var.project
    Env     = var.env
  }
}

resource "aws_iam_user_policy" "github_actions_policy" {
  user   = aws_iam_user.github_actions_user.name
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

data "aws_iam_policy_document" "codebuild_policy" {
  statement {
    actions = [
      "codebuild:StartBuild",
      "codebuild:BatchGetBuilds",
      "codebuild:StopBuild"
    ]
    resources = ["arn:aws:codebuild:ap-northeast-1:500337985842:project/${var.project}-${var.env}-frontend-app-build"]
    effect    = "Allow"
  }

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
    resources = [var.frontend_ecr_arn]
    effect    = "Allow"
  }

  statement {
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:ap-northeast-1:500337985842:log-group:/aws/codebuild/${var.project}-${var.env}-frontend-app-build:*"]
    effect    = "Allow"
  }
}
