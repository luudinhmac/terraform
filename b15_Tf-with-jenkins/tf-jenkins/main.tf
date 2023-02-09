terraform {
  backend "s3" {
    bucket   = "terraform-series-s3-backend"
    key      = "terraform-jenkins"
    region   = "us-east-2"
    encrypt  = true
    role_arn = "arn:aws:iam::${var.account_id}:role/Terraform-SeriesS3BackendRole"
  }
}

provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ami" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    owners = ["099720109477"]
}

resource "aws_instance" "server" {
    ami = data.aws_ami.ami.id
    instance_type = "t2.micro"

    lifecycle {
        create_before_destroy = false
    }

    tags {
        Name = "server"
    }
}

output {
    value = aws_instance.server.public_ip
}
