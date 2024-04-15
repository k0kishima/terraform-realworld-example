module "networking" {
  source = "../modules/networking"

  env            = "staging"
  project        = "realworld-example"
  vpc_cidr_block = "10.1.0.0/16"

  availability_zones = {
    ap-northeast-1a = {
      order = 0
      id    = "az1"
    }
    ap-northeast-1c = {
      order = 1
      id    = "az2"
    }
  }
}

module "alb" {
  source = "../modules/alb"

  env            = "staging"
  project        = "realworld-example"
  vpc_id         = module.networking.vpc_id
  public_subnets = module.networking.public_subnets
}

module "ecs" {
  source = "../modules/ecs"

  env                = "staging"
  project            = "realworld-example"
  vpc_id             = module.networking.vpc_id
  subnets            = module.networking.private_subnets
  alb_security_group = module.alb.alb_security_group_id
  ecs_security_group = module.ecs.ecs_security_group_id
  target_group_arn   = module.alb.target_group_arn
}

module "codebuild" {
  source = "../modules/codebuild"

  env      = "staging"
  project  = "realworld-example"
  repo_url = "https://github.com/k0kishima/nuxt3-realworld-example-app"
}
