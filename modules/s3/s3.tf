resource "aws_s3_bucket" "main" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = var.s3_bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_acl" "acl_for_bucket" {
  bucket = aws_s3_bucket.main.id
  acl    = var.s3_bucket_acl
}