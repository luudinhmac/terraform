variable "region" {
    type = string
    default = "us-east-2"
}

variable "project" {
    description = "The project name to use for unique resource naming"
    default = "terraform-series"
    type = string
}

variable "principal_arns" {
    description = "A list of principal arns allowed to assume the IAM role"
    default = "null"
    type = string
}
