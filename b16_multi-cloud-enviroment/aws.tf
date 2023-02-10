
# create aws vpc
data "aws_availability_zones" "available" {

}

module "vpc" {
    source = "terraform-aws-module/vpc/aws"
    version = "3.4.12"

    name = "aws-gpc"
    cidr = "10.0.0.0/16"
    azs = data.aws_availability_zones.available.names

    private_subnet = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnet = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

    enable_nat_gateway = true
    single_nat_network = true
}

# Create aws customer gateway
# ip_address of AWS Customer Gateway get from GCP External IP
resource "aws_customer_gateway" "gpc_customer_gateway" {
    bgp = 65000
    ip_address = google_compute_address.aws_customer_gateway.address
    type = "ipsec.1"

    tags = {
        Name = "gpc-customer-gateway"
    }
}

resource "aws_vpn_gateway" "aws_gpc" {
    vpc_id = module.vpc.vpc_id

    tags = {
        Name = "AWS-GPC"
    }
}


resource "aws_vpn_connection" "aws_gpc" {
    customer_gateway_id = aws_customer_gateway.gpc_customer_gateway.id
    vpn_gateway_id = aws_vpn_gateway.aws_gpc.id
    type = "ipsec.1"
    static_routes_only = true
}

resource "aws_vpn_connection_route" "office" { 
    destination_cidr_block = "10.168.0.0/20" // fix cidr block of gpc region on us-west-2
    vpn_connection_id = aws_vpn_connection.aws_gpc.id
}

