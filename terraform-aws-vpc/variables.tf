variable "region" {
  default = "us-west-2"

}

variable "security_group_name" {
  default = "VPC_01_SG"

}

variable "instance_type" {
  default = "t3.micro"

}

variable "keypair_name" {
  default = "terraform-deployer-key"

}