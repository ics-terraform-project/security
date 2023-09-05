# TO S3
# provider "aws" {
#   region     = var.aws_region
#   profile = "payersandbox"
# }

# terraform {
#   backend "s3" {
#     bucket = "adam-terraform"
#     key = "TF/payersandbox.tfstate" # FOLDER/name.tfstate
#     region = "ap-southeast-1"
#     profile = "payersandbox"
#     skip_region_validation = true
#   }
#   required_providers {
#     aws = {
#       version = ">= 2.7.0"
#       source = "hashicorp/aws"
#     }
#   }
# }

# TO LOCAL

provider "aws" {
  region     = var.region
  profile = "payersandbox"
}

terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
}