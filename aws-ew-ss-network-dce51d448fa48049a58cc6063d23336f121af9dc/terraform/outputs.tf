output "vpc_cidr" {
  value       = module.vpc.vpc_cidr_block
  description = "The primary IPv4 CIDR block of the VPC"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}
