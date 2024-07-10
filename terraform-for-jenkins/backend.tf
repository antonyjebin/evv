terraform {
  backend "s3" {
    bucket = "terraform-jenkins-eks-01"
    key    = "jenkins-server/terraform.tfstate"
    region = "us-west-2"
  }
}