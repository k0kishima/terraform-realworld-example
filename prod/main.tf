locals {
  env     = "prod"
  project = "realworld-example"
}

data "aws_ssm_parameter" "db_username" {
  name = "/realworld-example/staging/db/username"
}

data "aws_ssm_parameter" "db_password" {
  name            = "/realworld-example/staging/db/password"
  with_decryption = true
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

  env               = local.env
  project           = local.project
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
}

module "ecs" {
  source = "../modules/ecs"

  env                         = local.env
  project                     = local.project
  vpc_id                      = module.networking.vpc_id
  subnet_ids                  = module.networking.private_subnet_ids
  alb_security_group          = module.alb.alb_security_group_id
  target_group_arn            = module.alb.target_group_arn
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
}

module "ecr" {
  source = "../modules/ecr"

  env     = local.env
  project = local.project
}

module "iam" {
  source = "../modules/iam"

  env     = local.env
  project = local.project
}

module "database" {
  source             = "../modules/database"
  env                = local.env
  project            = local.project
  vpc_id             = module.networking.vpc_id
  vpc_cidr_block     = module.networking.vpc_cidr_block
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  private_subnet_ids = module.networking.private_subnet_ids
  master_username    = data.aws_ssm_parameter.db_username.value
  db_master_password = data.aws_ssm_parameter.db_password.value
}
