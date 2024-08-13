resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "${var.project}-${var.env}-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.03.0"
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.db_master_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name    = aws_db_subnet_group.aurora.name
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  storage_encrypted       = true
  skip_final_snapshot     = true

  availability_zones = var.availability_zones

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-aurora-cluster"
  }
}

resource "aws_db_subnet_group" "aurora" {
  name       = "${var.project}-${var.env}-aurora-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-aurora-subnet-group"
  }
}

resource "aws_security_group" "aurora_sg" {
  name        = "${var.project}-${var.env}-aurora-sg"
  description = "Aurora security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Env     = var.env
    Project = var.project
    Name    = "${var.project}-${var.env}-aurora-sg"
  }
}
