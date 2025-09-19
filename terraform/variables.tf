variable "iam_role_name" {
    type = string
    description = "Name of IAM role to create for EB EC2 instances (to pull from ECR)"
}

variable "eb_app_name" {
    type = string
    description = "Name of app to deploy using Elastic Beanstalk"
}

variable "eb_app_env_name" {
    type = string
    description = "Name of app env to create using Elastic Beanstalk"
}
