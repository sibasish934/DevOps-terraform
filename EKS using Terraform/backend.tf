terraform {
  backend "s3" {
    bucket = "testingjenkins12345"
    key = "EKS/terraform.tfstate"
    region = "ap-south-1"
  }
}