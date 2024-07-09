provider "aws" {
  region = "us-east-1"
}
data "aws_availability_zones" "available" {}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-bucket"
  acl    = "private"
  
  versioning {
    enabled = true
  }
}
