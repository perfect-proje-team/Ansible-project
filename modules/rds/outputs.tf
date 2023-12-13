output "db_security_group_id" {
  description = "ID of RDS security group"
  value       = aws_security_group.rds_security_group.id
}

output "replica-url" {
  value=aws_db_instance.replica-rds.endpoint
}