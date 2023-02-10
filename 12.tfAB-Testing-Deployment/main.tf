provider "aws" {
  region = "us-east-2"
}

output "dns" {
  value = "aws_cloudfront_dítribution.s3_distribution.domain_name"
}

output "s3" {
  value = {
    pro     = aws_s3_bucket.s3_pro_20230208.bucket_domain_name
    pre_pro = aws_s3_bucket.s3_pre_pro_20230208.bucket_domain_name
  }
}
