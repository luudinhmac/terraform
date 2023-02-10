# Create gpc vpc
resource "google_compute_network" "aws_gpc" {
    name = "aws-gpc"
}

# create gpc external ip 
resource "google_compute_address" "aws_customer_gateway" {
    name = "aws-customer_gateway"
}

# Create VPN gateway for gpc vpc
resource "google_compute_vpn_gateway" "aws_gpc" {
    name =  "aws-gpc"
    network = google_compute_network.aws_gpc.id
}

resource "google_compute_forwarding_rule" "fr_esp" {
    name = "fr-esp"
    ip_protocal = "ESP"
    ip_address = google_compute_address.aws_customer_gateway.address
    target = google_compute_vpn_gateway.aws_gpc.id
}

resource "google_compute_forwarding_rule" "fr_udp500" {
    name = "fr-udp500"
    ip_protocal = "UDP"
    ip_address = google_compute_address.aws_customer_gateway.address
    target = google_compute_vpn_gateway.aws_gpc.id
}

resource "google_compute_forwarding_rule" "fr_udp4500" {
    name = "fr-udp4500"
    ip_protocal = "UDP"
    ip_address = google_compute_address.aws_customer_gateway.address
    target = google_compute_vpn_gateway.aws_gpc.id
}

# create vpn site to site
resource "google_compute_vpn_tunnel" "tunnel_1" {
    name = "tunnel_1"
    perr_ip = aws_vpn_connection.aws_gpc.tunnel1_address
    shared_secret = aws_vpn_connection.aws_gpc.tunnel1_preshared_key

    target_vpn_gateway = google_compute_vpn_gateway.aws_gcp.id

    depends_on = [
        google_compute_forwarding_rule.fr_esp,
        google_compute_forwarding_rule.fr_udp500,
        google_compute_forwarding_rule.fr_udp4500
    ]

}

resource "google_compute_route" "route_1" {
    name = "route_1"
    network = google_compute_network.aws_gpc.name
    dest_range = module.vpc.vpc_cidr_block
    priority = 1000

    next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel_1.id
}

