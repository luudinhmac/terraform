provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-bucket-2023-01-02"

  tags = {
    Name = "Terraform Series"
  }
}
