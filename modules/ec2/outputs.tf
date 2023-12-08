output "security_group_id" {
  description = "ID of EC2 security group"
  value       = aws_security_group.ec2_security_group.id
}

output "ec2_iam_role" {
  description = "ID of EC2 security group"
  value       = aws_iam_role.ec2_role.name
}