terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}


resource "aws_s3_bucket" "static" {
  bucket        = "terraform-series-bai3-20230202"
  force_destroy = true
  #tags          = local.tags
}

# acl for s3 bucket
resource "aws_s3_bucket_acl" "static" {
  bucket = aws_s3_bucket.static.id
  acl    = "public-read"
}

# configuration website bucket
resource "aws_s3_bucket_website_configuration" "static" {
  bucket = aws_s3_bucket.static.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# Policy not using file
data "aws_iam_policy_document" "static" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static.arn}/*"]

    principals {
      type        = "*"
      identifiers = [""]
    }
  }
}


# local block
locals {
  mime_types = {
    html  = "text/html"
    css   = "text/css"
    ttf   = "font/ttf"
    woff  = "font/woff"
    woff2 = "font/woff2"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
    jpg   = "image/jpeg"
    png   = "image/png"
    svg   = "image/svg+xml"
    eot   = "application/vnd.ms-fontobject"
  }
}

# Upload file to s3
resource "aws_s3_object" "object" {
  for_each     = fileset(path.module, "static-web/**/*")
  bucket       = aws_s3_bucket.static.id
  key          = replace(each.value, "static-web", "")
  source       = each.value
  etag         = filemd5("${each.value}")
  content_type = lookup(local.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}

# Add policy for s3
resource "aws_s3_bucket_policy" "static" {
  bucket = aws_s3_bucket.static.id
  policy = file("s3_static_policy.json")
  # policy = data.aws_iam_policy_document.static.json   # not using file
}
