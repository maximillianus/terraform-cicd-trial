# # Without HCP Terraform
# terraform {
#   required_version = "1.10.3"

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.82.2"
#     }
#   }
# }

terraform {
  required_version = "1.10.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.82.2"
    }
  }

  cloud {
  }
}

resource "terraform_data" "run-script" {
  provisioner "local-exec" {
    command = "${path.module}/hello.sh"
  }


}

# provider "aws" {
#   region = "ap-southeast-1"
# }

# resource "aws_instance" "gh-action-instance" {
#   ami           = "ami-04c913012f8977029" # Replace with a valid AMI ID in your region
#   instance_type = "t3a.nano"

#   tags = {
#     Name = "ec2-github-action-test"
#   }
# }