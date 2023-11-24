terraform {
  backend "s3" {
    bucket = "testingjenkins12345"
    key = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}