# IAM Role required for Elastic Beanstalk App to pull to/from ECR
module "eb_iam_role" {
    source = "./modules/iam"
    iam_role_name = var.eb_iam_role_name
}

# ECR Repo required to store images in
module "ecr_repo" {
  source = "./modules/ecr"
}

# Deploy app via Elastic Beanstalk
module "eb_app" {
    source = "./modules/elastic_beanstalk"
    eb_app_name = var.eb_app_name
    eb_app_env_name = var.eb_app_env_name
    service_role_arn = module.eb_iam_role.service_role_arn
    iam_instance_profile_name = module.eb_iam_role.eb_instance_profile_name
    app_s3_bucket = module.s3_bucket.bucket_id
    app_zip_file_key = module.s3_bucket.app_zip_file_id
}

# S3 Bucket to store source bundle in (docker-compose.yml must be zipped and stored in S3 for EB to work)
module "s3_bucket" {
    source = "./modules/s3"  
}