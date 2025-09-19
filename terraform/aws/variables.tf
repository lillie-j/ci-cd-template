variable "aws_region" {
  type        = string
  description = "Region to create resources in. Programmatic format e.g. 'eu-west-2', not 'Europe (London)'"
  default     = "eu-west-2"
}

variable "eb_iam_role_name" {
  type        = string
  description = "Name of the IAM role to be assumed by Elastic Beanstalk (needed to pull from ECR etc.)"
  default = "eb_cicdapp_iam_role"
}

variable "eb_app_name" {
  type        = string
  description = "Name of the Elastic Beanstalk App to create"
}

variable "eb_app_env_name" {
  type        = string
  description = "Name of the Elastic Beanstalk App Environment to create"
}




