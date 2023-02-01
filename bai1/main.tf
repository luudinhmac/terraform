provider "aws" {
  region = "us-east-2"
}
resource "aws_instance" "bai1" {
  ami           = "ami-05bfbece1ed5beb54"
  instance_type = "t2.micro"
  tags = {
    "Name" = "Bai1"
  }
}
