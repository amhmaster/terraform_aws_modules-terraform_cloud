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