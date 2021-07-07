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
  name        = var.security_group_name
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = var.security_group_name
  }

}

# Configure the EC2 instance in a public subnet

resource "aws_instance" "public_instance" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.security-group.id]
  key_name                    = var.keypair_name

  subnet_id = aws_subnet.public.id

}

# Configure the EC2 instance in a private subnet

resource "aws_instance" "private_instance" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = false
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.security-group.id]
  key_name                    = var.keypair_name

  subnet_id = aws_subnet.private.id

}