terraform {
  required_providers {
    aws = {
      sousource = "hashicorp/aws"
      version   = "~> 3.35.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}