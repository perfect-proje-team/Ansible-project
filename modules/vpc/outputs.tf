output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = aws_vpc.main_vpc.arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "default_security_group_id" {
  description = "The ID of the security group created by VPC module"
  value       = aws_security_group.default_group.id
}


output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private_route.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public_route.id
}

output "public_subnets" {
  description = "List of public subnets"
  value       = [for i in aws_subnet.main_public_subnets : i.id]
}

output "private_subnets" {
  description = "List of private subnets"
  value       = [for i in aws_subnet.main_private_subnets : i.id]
}



