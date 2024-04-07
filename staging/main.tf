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
