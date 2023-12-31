output "vpc_id" {
  description = "The ID of VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets_ids" {
  description = "Private Subnets IDs"
  value       = module.vpc.private_subnets
}

output "security_group_id" {
  description = "Security Group IDs"
  value       = module.vpc.default_security_group_id
}

output "public_subnets_id" {
  description = "Public Subnets IDs"
  value       = module.vpc.public_subnets
}

output "ec2_instance_id" {
  description = "EC2 instance IDs"
  value       = module.ec2_instance.id
}

