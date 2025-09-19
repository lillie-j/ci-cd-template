## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eb_app"></a> [eb\_app](#module\_eb\_app) | ./modules/elastic_beanstalk | n/a |
| <a name="module_eb_iam_role"></a> [eb\_iam\_role](#module\_eb\_iam\_role) | ./modules/iam | n/a |
| <a name="module_ecr_repo"></a> [ecr\_repo](#module\_ecr\_repo) | ./modules/ecr | n/a |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | ./modules/s3 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region to create resources in. Programmatic format e.g. 'eu-west-2', not 'Europe (London)' | `string` | `"eu-west-2"` | no |
| <a name="input_eb_app_env_name"></a> [eb\_app\_env\_name](#input\_eb\_app\_env\_name) | Name of the Elastic Beanstalk App Environment to create | `string` | n/a | yes |
| <a name="input_eb_app_name"></a> [eb\_app\_name](#input\_eb\_app\_name) | Name of the Elastic Beanstalk App to create | `string` | n/a | yes |
| <a name="input_eb_iam_role_name"></a> [eb\_iam\_role\_name](#input\_eb\_iam\_role\_name) | Name of the IAM role to be assumed by Elastic Beanstalk (needed to pull from ECR etc.) | `string` | `"eb_cicdapp_iam_role"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repo_url"></a> [ecr\_repo\_url](#output\_ecr\_repo\_url) | URL of ECR Repo used to store app images |
| <a name="output_source_bucket_id"></a> [source\_bucket\_id](#output\_source\_bucket\_id) | ID of S3 bucket used to store source bundle |
