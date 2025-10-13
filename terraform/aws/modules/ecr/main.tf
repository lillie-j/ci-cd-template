resource "aws_ecr_repository" "ci_cd_repo_frontend" {
  name                 = "ci-cd-template-frontend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "ci_cd_repo_backend" {
  name                 = "ci-cd-template-backend"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}