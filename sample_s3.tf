terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.51"
    }
  }
}
provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}
resource "aws_s3_bucket" "vpctestbucket" {
  bucket = "vpctestbucket2309"

  tags = {
    Name        = "My bucket"
    Environment = "VPC_Endpoint_test"
  }
}
