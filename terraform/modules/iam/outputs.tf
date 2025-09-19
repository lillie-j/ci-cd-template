output "service_role_arn" {
    value = aws_iam_role.eb_service_role.arn
}

output "eb_instance_profile_name" {
    value = aws_iam_instance_profile.eb_instance_profile.name
}