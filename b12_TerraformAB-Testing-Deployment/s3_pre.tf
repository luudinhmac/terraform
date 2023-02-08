resource "aws_s3_bucket" "s3_pre_pro_20230208" {
  bucket        = "terraform-serries-s3-pre-pro"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "s3_pre_pro_20230208" {
  bucket = aws_s3_bucket.s3_pre_pro_20230208.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "s3_pre_pro_20230208" {
  bucket = aws_s3_bucket.s3_pre_pro_20230208.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

data "aws_iam_policy_document" "s3_pre_pro_20230208" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_pre_pro_20230208.arn}/*"]

    principals {
      type = "AWS"
      identifiers = [
        aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_pre_pro_20230208" {
  bucket = aws_s3_bucket.s3_pre_pro_20230208.id
  policy = data.aws_iam_policy_document.s3_pre_pro_20230208.json
}
