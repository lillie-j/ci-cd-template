resource "aws_s3_bucket" "app_bucket" {
    bucket = "ci-cd-app-bucket"
}

resource "aws_s3_object" "app_zip" {
    bucket = aws_s3_bucket.app_bucket.id
    key = "app.zip"
    source = "../app/app.zip"
}