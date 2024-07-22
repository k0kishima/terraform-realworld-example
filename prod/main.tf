locals {
  env     = "prod"
  project = "realworld-example"
}

module "networking" {
  source = "../modules/networking"

  env            = local.env
  project        = local.project
  vpc_cidr_block = "10.0.0.0/16"

  availability_zones = {
    ap-northeast-1a = {
      order = 1
      id    = "az1"
    }
    ap-northeast-1c = {
      order = 2
      id    = "az2"
    }
    ap-northeast-1d = {
      order = 3
      id    = "az3"
    }
  }
}

module "alb" {
  source = "../modules/alb"

  env            = local.env
  project        = local.project
  vpc_id         = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
}

module "ecs" {
  source = "../modules/ecs"

  env                = local.env
  project            = local.project
  vpc_id             = module.networking.vpc_id
  subnets            = module.networking.private_subnets
  alb_security_group = module.alb.alb_security_group_id
  target_group_arn   = module.alb.target_group_arn
}

module "ecr" {
  source = "../modules/ecr"

  env     = local.env
  project = local.project
}

module "codebuild" {
  source = "../modules/codebuild"

  env               = local.env
  project           = local.project
  repo_url          = var.frontend_app_repo_url
  frontend_ecr_name = module.ecr.frontend_name
}

module "iam" {
  source = "../modules/iam"

  env              = local.env
  project          = local.project
  frontend_ecr_arn = module.ecr.frontend_arn
}
