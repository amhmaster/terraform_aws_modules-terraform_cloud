variable "aws_region" {
  description = "AWS Region to Deploy Resource into"
  type        = string
  default     = "ap-southeast-1"
}

variable "subnet_for_vpc" {
  description = "Subnet for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availiblity_zone" {
  description = "Availibility Zones for VPC"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "private_subnets_azs" {
  description = "Private Subnets for Availibility Zones"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets_azs" {
  description = "Public Subnets for Availibility Zones"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "instance" {
  description = "Name of instance"
  type        = string
  default     = "nginx-server"
}

variable "key_pair" {
  description = "Name of Key Pair"
  type        = string
  default     = "nginx-key"
}

variable "security_group_name" {
  description = "security group name"
  type        = string
  default     = "sg-for-nginx"
}

variable "db_name" {
  description = "name for db"
  type        = string
  default     = "rds-aurora-mysql"
}

variable "db_password" {
  description = "master password for db"
  type        = string
  default     = "Asd123!@"
}

variable "db_subnet_group" {
  description = "subnet group for RDS"
  type        = string
  default     = "db-subnet-group"
}

variable "rds_sg" {
  description = "security group for RDS"
  type        = string
  default     = "ec2-rds-sg"
}
