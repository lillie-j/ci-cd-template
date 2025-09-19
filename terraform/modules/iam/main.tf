# Create IAM Role
resource "aws_iam_role" "eb_service_role" {
    name = var.iam_role_name

    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
                Action = "sts:AssumeRole"
            }
        ]
    })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "eb_instance_ecr_read" {
    role = aws_iam_role.eb_service_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Create instace profile for use by EB EC2 instances
resource "aws_iam_instance_profile" "eb_instance_profile" {
    name = "eb-instance-profile"
    role = aws_iam_role.eb_service_role.name
}