provider "aws" {
  region = "us-uest-2"
}

resource "aws_s3_bucket" "static" {
  bucket = "terraform-series-bai3-20230202"
  acl    = "public-read"
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": [
          "arn:aws:s3:::terraform-series-bai3-20230202/*"
        ]
      }
    ]
  }
  POLICY

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
