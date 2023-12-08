output "bucket_name" {
  description = "the name of S3 bucket"
  value       = aws_s3_bucket.main.bucket
}