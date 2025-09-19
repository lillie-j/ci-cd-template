output "bucket_id" {
    value = aws_s3_bucket.app_bucket.id
}

output "app_zip_file_id" {
    value = aws_s3_object.app_zip.key
}