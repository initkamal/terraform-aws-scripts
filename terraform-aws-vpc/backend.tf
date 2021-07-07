terraform {
  backend "s3" {
    bucket = "backendtf00"
    key    = "task01_BKED.tf"
    region = "us-west-2"
  }
}