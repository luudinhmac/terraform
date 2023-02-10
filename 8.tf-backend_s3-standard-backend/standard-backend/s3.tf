resource "aws_s3_bucket" "s3_bucket-20230206" {
  bucket        = "${var.project}-s3-backend-20230206"
  force_destroy = false

  tags = local.tags
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket-20230206.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket-20230206.id

  versioning_configuration {  
    status = "Enabled"
  }
}

resource "aws_kms_key" "kms_key" {
  tags = local.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket-20230206.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.kms_key.arn
    }
  }
}