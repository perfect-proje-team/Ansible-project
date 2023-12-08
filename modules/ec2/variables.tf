variable "ami" {
  description = "The ID of Amazon Machine Image"
  type        = string

}

variable "instance_type" {
  description = "type of EC2 instance"
  type        = string

}

variable "user_data" {
  description = "AZ names for private subnets"
  type        = string
  default     = null

}

variable "subnet_id" {
  description = "ID of subnet in which to launch"
  type        = string

}

variable "key_name" {
  description = "Name of EC2 key pair"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  type        = string
  description = "name of iam instance profile"

}

variable "ec2_name" {
  description = "Name of the EC2"
  type        = string

}

variable "ec2_role_name" {
  description = "name of EC2 role"
  type        = string

}

variable "assume_role_policy" {
  type = string

}

variable "ec2_security_group_name" {
  type    = string
  default = "ec2-security-group"

}

variable "vpc_id" {
  type = string

}

variable "environment" {
  description = "environment"
  type        = string

}

