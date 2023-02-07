data "aws_caller_identity" "current" {}

variable "account_id" {
  default = data.aws_caller_identity.current.account_id
}
