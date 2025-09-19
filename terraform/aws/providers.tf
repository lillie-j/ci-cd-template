terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 6.0"
        }
    }
}

# Creds pulled from AWS/AZ CLI, no need to configure here
provider "aws" {
    region = var.aws_region
}
