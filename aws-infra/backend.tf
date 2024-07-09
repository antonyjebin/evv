terraform {
  backend "s3" {
    bucket         = "testundpdf"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
