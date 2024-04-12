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
