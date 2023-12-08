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
  skip_final_snapshot = true
}

resource "aws_security_group" "rds_security_group" {
  name        = var.rds_security_group_name
  description = "security group of rds instance"
  vpc_id      = var.vpc_id

}