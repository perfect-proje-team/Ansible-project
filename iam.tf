data "aws_iam_policy_document" "s3_policy" {
  statement {
    effect    = "Allow"
    actions   = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
    resources = [
      "arn:aws:s3:::${module.S3_bucket.bucket_name}/*",
        "arn:aws:s3:::${module.S3_bucket.bucket_name}"
        ]
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "s3-access-policy"
  description = "S3 access policy for EC2"
  policy      = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_iam_policy_attachment" "s3_attach" {
  name       = "s3-attachment"
  roles      = [module.ec2_instance.ec2_iam_role]
  policy_arn = aws_iam_policy.s3_access.arn
}

data "aws_iam_policy_document" "rds_policy" {
  statement {
    effect    = "Allow"
    actions   = ["rds-db:connect"]
    resources = ["arn:aws:rds-db:${var.region}:${data.aws_caller_identity.current.account_id}:db:${var.db_name}"]
  }
}

resource "aws_iam_policy" "rds_access" {
  name        = "rds-connect-policy"
  description = "RDS access policy for EC2"
  policy      = data.aws_iam_policy_document.rds_policy.json
}

resource "aws_iam_policy_attachment" "rds_attach" {
  name       = "rds-attachment"
  roles      = [module.ec2_instance.ec2_iam_role]
  policy_arn = aws_iam_policy.rds_access.arn
}
