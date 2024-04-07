resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-vpc"
  }
}

resource "aws_subnet" "private" {
  for_each          = var.availability_zones
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, 0 + each.value.order)

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-private-${each.value.id}"
  }
}

resource "aws_subnet" "public" {
  for_each          = var.availability_zones
  vpc_id            = aws_vpc.this.id
  availability_zone = each.key
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, 3 + each.value.order)

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-public-${each.value.id}"
  }
}
