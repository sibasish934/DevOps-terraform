terraform {
  backend "s3" {
    bucket = "cicd-bucket12334"
    key = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}