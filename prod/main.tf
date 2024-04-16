module "networking" {
  source = "../modules/networking"

  env            = "prod"
  project        = "realworld-example"
  vpc_cidr_block = "10.0.0.0/16"

  availability_zones = {
    ap-northeast-1a = {
      order = 0
      id    = "az1"
    }
    ap-northeast-1c = {
      order = 1
      id    = "az2"
    }
    ap-northeast-1d = {
      order = 2
      id    = "az3"
    }
  }
}

module "alb" {
  source = "../modules/alb"

  env            = "prod"
  project        = "realworld-example"
  vpc_id         = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
}

module "ecs" {
  source = "../modules/ecs"

  env                     = "prod"
  project                 = "realworld-example"
  vpc_id                  = module.networking.vpc_id
  subnets                 = module.networking.private_subnets
  alb_security_group      = module.alb.alb_security_group_id
  ecs_security_group      = module.ecs.ecs_security_group_id
  target_group_arn        = module.alb.target_group_arn
  frontend_repository_url = module.ecr.frontend_repository_url
}

module "ecr" {
  source = "../modules/ecr"

  env     = "prod"
  project = "realworld-example"
}

module "codebuild" {
  source = "../modules/codebuild"

  env               = "prod"
  project           = "realworld-example"
  repo_url          = "https://github.com/k0kishima/nuxt3-realworld-example-app"
  frontend_ecr_name = module.ecr.frontend_name
}

module "iam" {
  source = "../modules/iam"

  env              = "prod"
  project          = "realworld-example"
  frontend_ecr_arn = module.ecr.frontend_arn
}
