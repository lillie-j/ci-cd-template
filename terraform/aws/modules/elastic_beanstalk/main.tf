resource "aws_elastic_beanstalk_application" "cicd_app_test" {
    name = var.eb_app_name
    description = "An app to validate CI/CD pipeline"
}

resource "aws_elastic_beanstalk_application_version" "app_version" {
    application = aws_elastic_beanstalk_application.cicd_app_test.name
    bucket = var.app_s3_bucket
    key = var.app_zip_file_key
    name = "v1"
}

resource "aws_elastic_beanstalk_environment" "cicd_app_env" {
    for_each = toset(["dev", "prod"])
    name = "${var.eb_app_env_name}-${each.key}"
    description = "App environment for test app to validate CI/CD pipeline"
    application = aws_elastic_beanstalk_application.cicd_app_test.name
    solution_stack_name = "64bit Amazon Linux 2023 v4.7.1 running Docker"
    tier = "WebServer"

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "ServiceRole"
        value = var.service_role_arn
    }

    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "IamInstanceProfile"
        value = var.iam_instance_profile_name
    }

    
    setting {
        namespace = "aws:autoscaling:launchconfiguration"
        name = "InstanceType"
        value = "t3.small"
    }

    setting {
        namespace = "aws:autoscaling:asg"
        name = "MinSize"
        value = "1"
    }
    
    setting {
        namespace = "aws:autoscaling:asg"
        name = "MaxSize"
        value = "2"
    }

    setting {
        namespace = "aws:elasticbeanstalk:environment"
        name = "LoadBalancerType"
        value = "application"
    }

}