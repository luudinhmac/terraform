provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["746186632829"]
}

resource "aws_instance" "hello" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type # change here
}
