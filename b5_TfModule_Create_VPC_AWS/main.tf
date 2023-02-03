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

# Create vpc
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    "Name" = "Custom_VPC"
  }
}

# resource "aws_subnet" "private_subnet_2a" {
#     vpc_id = aws_vpc.myvpc.id
#     cidr_block = "10.0.0.0/24"
#     availability_zone = "us-east-2a"

#     tags = {
#       "Name" = "private_subnet"
#     }
# }

# resource "aws_subnet" "private_subnet_2b" {
#     vpc_id = aws_vpc.myvpc.id
#     cidr_block = "10.0.1.0/24"
#     availability_zone = "us-east-2b"

#     tags = {
#       "Name" = "private_subnet"
#     }
# }

# resource "aws_subnet" "private_subnet_2c" {
#     vpc_id = aws_vpc.myvpc.id
#     cidr_block = "10.0.2.0/24"
#     availability_zone = "us-east-2c"

#     tags = {
#       "Name" = "private_subnet"
#     }
# }

# local block
locals {
  private = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  public  = ["10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24"]
  zone    = ["us-east-2a", "us-east-2b", "us-east-2c"]
  tags    = ["private-subnet", "public-subnet"]
}

# Create private subnets
resource "aws_subnet" "private_subnet" {
  count             = length(local.private)
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = local.private[count.index]
  availability_zone = local.zone[count.index % length(local.zone)]
  tags = {
    "Name" = local.tags[0]
  }
}

# Create public subnets
resource "aws_subnet" "public_subnet" {
  count = length(local.public)

  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = local.public[count.index]
  availability_zone = local.zone[count.index % length(local.zone)]
  tags = {
    "Name" = local.tags[1]
  }
}

# Create Internet gateway
resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    "Name" = "custome_igw"
  }
}

# association internet gateway into route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_ig.id
  }
  tags = {
    "Name" = "public"
  }
}

# association route table for subnets
resource "aws_route_table_association" "public_association" {
  for_each       = { for i, j in aws_subnet.public_subnet : i => j }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Create NAT gateway
resource "aws_eip" "nat" {
  vpc = true
}

# Create NAT gateway
resource "aws_nat_gateway" "public" {
  depends_on = [aws_internet_gateway.ig]

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "Public NAT"
  }
}

# Create private route table and association Nat
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }
  tags = {
    "Name" = "private"
  }
}

# Associate route table into private subnets
resource "aws_route_table_association" "public_private" {
  for_each    = { for i, j in aws_subnet.private_subnet : i => j }
  subnet_id   = each.value.id
  route_table = aws_route_table.private.id
}
