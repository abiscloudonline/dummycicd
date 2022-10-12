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

resource "aws_dynamodb_table" "state_locking" {
  hash_key = "LockID"
  name     = "dynamodb-state-locking"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}

terraform {
    backend "s3" {
        bucket = "terraform-tfstate-s3-bucket"
        key    = "terraform/remote/s3/terraform.tfstate"
        region     = "ap-south-1"
       dynamodb_table  = "dynamodb-state-locking"
    }
} 
