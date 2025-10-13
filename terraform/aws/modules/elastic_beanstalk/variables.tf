variable "eb_app_name" {
    type = string
    description = "Name of app to deploy using Elastic Beanstalk"
}

variable "eb_app_env_name" {
    type = string
    description = "Base name of app env to create using Elastic Beanstalk"
}

variable "service_role_arn" {
    type = string
    description = "ARN of service role to be assumed by Elastic Beanstalk"
}

variable "iam_instance_profile_name" {
    type = string
    description = "Name of IAM instance profile to be assumed by Elastic Beanstalk EC2s"
}

variable "app_s3_bucket" {
    type = string
    description = "Name of S3 bucket which app.zip is stored in"
}

variable "app_zip_file_key" {
    type = string
    description = "Key of app zip file"
}
