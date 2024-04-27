terraform {
    
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.26.0"
    }
  }
 

  cloud {
    workspaces {
      name = "terraform_aws_modules-terraform_cloud"
    }
  }
}

provider "aws" {
  region  = var.aws_region
}

# provider "aws" {
#   shared_config_files      = ["/home/vagrant/.aws/config"]
#   shared_credentials_files = ["/home/vagrant/.aws/credentials"]
#   profile                  = "amh-bca-aws-prod"
#   # alias                  = "thanhtikesoe"              
#   region = var.aws_region
# }

