provider "aws" {
    region = "us-east-2"
}
# algorithm crete key
resource "tls_private_key" "key" {
    algorithm = "RSA"
}
# create key
resource "aws_key_pair" "key_pair" {
    key_name = "ansible-key"
    public_key = tls_private_key.key.public_key_openssh
}
# Configure SG allow ssh to EC2
resource "aws_security_group" "allow_ssh" { 
    ingress {
        from_port = 22
        to_port    = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    engress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Create EC2
data "aws_ami" "ami" {
    most_recent = true

    filter {
        namee = "name"
        values = ["amzn2-ami-hvm-2.0.*.x86_64-gp2"]
    }

    owners = ['amazon']
}

resource "aws_instance" "ansible_server" {
    ami = data.aws_ami.ami.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh.id]
    key_name = aws_key_pair.key_pair.name


    // Using remote-exec
    provisionor "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo yum install -y httpd.x86_64",
            "sudo systemctl start httpd",
            "sudo systemctl enable httpd"
        ]

        // Authenticate for remote
        connection {
            type = "ssh"
            user = "ec2-user"
            private_key = tls_private_key.key.private_key_pem
            host = self.public_ip
        }
    }

    tags = {
        name = "apache server"
    }
}

