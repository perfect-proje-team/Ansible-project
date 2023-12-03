variable "region_name" {
  description = "Region name to launch vpc network"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC network CIDR"
  type        = string
}

variable "environment" {
  description = "Environment name for deployment"
  type        = string
}

variable "public_subnets" {
  description = "Provider public subnets CIDR values"
  type        = list(string)
}

variable "private_subnets" {
  description = "Provider private subnets CIDR values"
  type        = list(string)
}

variable "public_az" {
  description = "AZ names for public subnets"
  type        = list(string)
}

variable "private_az" {
  description = "AZ names for private subnets"
  type        = list(string)
}