data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "security-group" {
  name        = var.sgName
  description = "Allow TLS inbound traffic"

  ingress {
    description = "Security Group"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sgName
  }

}

resource "aws_eip" "eip" {
  instance = aws_instance.ec2server.id
  vpc      = true

  tags = {
    Name = var.ec2Name
  }

}

resource "aws_eip_association" "eip-assoc" {
  instance_id   = aws_instance.ec2server.id
  allocation_id = aws_eip.eip.id

}

resource "aws_key_pair" "terraform-key" {
  key_name   = var.keyName
  public_key = file("${path.module}/ssh-key/id_rsa.pub")

}

resource "aws_instance" "ec2server" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.instance-type
  security_groups = ["${var.sgName}"]
  key_name        = aws_key_pair.terraform-key.id

  tags = {
    Name = var.ec2Name
  }

}
