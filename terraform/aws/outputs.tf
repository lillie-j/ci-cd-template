output "source_bucket_id" {
    value = module.s3_bucket.bucket_id
    description = "ID of S3 bucket used to store source bundle"
}

output "ecr_repo_url" {
    value = module.ecr_repo.ecr_repo_url
    description = "URL of ECR Repo used to store app images"
}