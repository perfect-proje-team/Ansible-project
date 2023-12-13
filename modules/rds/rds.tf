resource "aws_db_subnet_group" "default" {
  name       = var.subnet_group_name
  subnet_ids = var.db_subnet_ids

}

resource "aws_db_instance" "rds_db" {
  allocated_storage   = 10
  db_name             = var.db_name
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = var.instance_class
  username            = var.user_name
  password            = var.password
  backup_retention_period = 7
  skip_final_snapshot = true
  multi_az = true
}

resource "aws_db_instance" "replica-rds" {
  instance_class       = "db.t3.micro"
  skip_final_snapshot  = true
  backup_retention_period = 7
  replicate_source_db = aws_db_instance.rds_db.identifier
}



resource "aws_security_group" "rds_security_group" {
  name        = var.rds_security_group_name
  description = "security group of rds instance"
  vpc_id      = var.vpc_id

}