output "security_group_id" {
  description = "ID of EC2 security group"
  value       = aws_security_group.ec2_security_group.id
}