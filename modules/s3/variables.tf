variable "s3_bucket_name" {
    description = "S3 bucket name, we should choose a global unique name"
  type        = string
  
}

variable "environment" {
  description = "AZ names for private subnets"
  type        = string
  
}

variable "s3_bucket_acl" {
    description = "S3 Bucket Access Control List"
    default = "private"

}