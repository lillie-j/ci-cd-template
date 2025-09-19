resource "aws_ecr_repository" "ci_cd_repo" {
  name                 = "ci_cd_repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}