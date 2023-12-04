<!-- BEGIN_TF_DOCS -->
## AWS S3 Bucket

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.acl_for_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | AZ names for private subnets | `string` | n/a | yes |
| <a name="input_s3_bucket_acl"></a> [s3\_bucket\_acl](#input\_s3\_bucket\_acl) | S3 Bucket Access Control List | `string` | `"private"` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 bucket name, we should choose a global unique name | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->