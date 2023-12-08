variable "subnet_group_name" {
  description = "name of subnet group"
  type        = string
  default     = "rds-subnet"

}

variable "db_subnet_ids" {
  description = "A list of VPC subnet IDs."
  type        = list(string)

}

variable "db_name" {
  description = "RDS database name"
  type        = string

}

variable "instance_class" {
  description = "Instance class of RDS database"
  type        = string
  default     = "db.t3.micro"

}

variable "user_name" {
  description = "User name of RDS database"
  type        = string

}

variable "password" {
  description = "password of database"
  type        = string

}

variable "rds_security_group_name" {
  type    = string
  default = "rds-security-group"

}

variable "vpc_id" {
  type = string

}