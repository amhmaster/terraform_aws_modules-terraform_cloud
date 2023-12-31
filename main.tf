module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
#   region        = var.aws_region
  cidr                        = var.subnet_for_vpc
  azs                         = var.availiblity_zone
  private_subnets             = var.private_subnets_azs
  public_subnets              = var.public_subnets_azs
  default_security_group_name = var.security_group_name
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = var.key_pair
  create_private_key = true
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  depends_on                  = [module.vpc.public_subnets]
  name                        = var.instance
  ami                         = "ami-05fb0b8c1424f266b"
  instance_type               = "t2.micro"
  key_name                    = module.key_pair.key_pair_name 
  associate_public_ip_address = true
  monitoring                  = false
  vpc_security_group_ids      = [module.vpc.default_security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
module "aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name            = var.db_name
  engine          = "aurora-mysql"
  engine_version  = "8.0"
  master_username = "root"
  master_password = var.db_password
  instances = {
    1 = {
      instance_class      = "db.t3.medium"
      publicly_accessible = false
    }
    # 2 = {
    #   identifier     = "mysql-static-1"
    #   instance_class = "db.r5.2xlarge"
    # }
    # 3 = {
    #   identifier     = "mysql-excluded-1"
    #   instance_class = "db.r5.xlarge"
    #   promotion_tier = 15
    # }
  }

  vpc_id                          = module.vpc.vpc_id
  instances_use_identifier_prefix = true
  create_db_subnet_group          = true
  db_subnet_group_name            = var.db_subnet_group
  subnets                         = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]
  publicly_accessible             = false
  create_security_group           = true
  security_group_name             = var.rds_sg
  depends_on = [
    module.vpc
  ]
  security_group_rules = {
    ingress = {
      description = "allow traffic from ec2 instance"
      instance    = module.ec2_instance.id
      cidr_blocks = module.vpc.public_subnets[0]
      port        = 3306
    }
  }

  apply_immediately   = true
  skip_final_snapshot = true

}
# module "cluster" {
#   source  = "terraform-aws-modules/rds-aurora/aws"

#   name           = "test-aurora-db-postgres96"
#   engine         = "aurora-postgresql"
#   engine_version = "14.5"
#   # master_username = "admin"
#   # master_password = var.db_password
#   instance_class  = "db.t3.medium"
#   instances = {
#     one = {
#       instance_class = "db.t3.medium"
#     }
#   }

#   vpc_id                          = module.vpc.vpc_id
#   instances_use_identifier_prefix = true
#   create_db_subnet_group          = true
#   db_subnet_group_name            = "db-subnet-group"
#   subnets                         = [module.vpc.private_subnets[0],module.vpc.private_subnets[1]]
#   publicly_accessible             = false
#   create_security_group           = true
#   security_group_name             = "ec2-rds-sg"

#   storage_encrypted   = true
#   apply_immediately   = true
#   monitoring_interval = 10

#   enabled_cloudwatch_logs_exports = ["postgresql"]

#   tags = {
#     Environment = "dev"
#     Terraform   = "true"
#   }
# }