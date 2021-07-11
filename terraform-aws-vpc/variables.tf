variable "region" {
  default = "us-west-2"

}

variable "security_group_name" {
  default = "VPC_01_SG"

}

variable "security_group_ports" {
  type        = list(number)
  description = "List of Ingress ports"
  default     = [22, 80, 443]

}

variable "instance_type" {
  default = "t3.micro"

}

variable "keypair_name" {
  default = "terraform-deployer-key"

}

variable "alb_name" {
  default = "VPC_01_alb"

}