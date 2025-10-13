output "ecr_repo_backend_url" {
    value = aws_ecr_repository.ci_cd_repo_backend.repository_url
}
output "ecr_repo_frontend_url" {
    value = aws_ecr_repository.ci_cd_repo_frontend.repository_url
}

