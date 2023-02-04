variable "projec" {
    type = string  
}

variable "vpc_cidr" {
    type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
    type = list(string)
}

variable "database-subnets" {
    type = list(string)  
}
