# Internet VPC
resource "aws_vpc" "BMO" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "BMO"
    }
}


# Subnets
resource "aws_subnet" "BMO-public-1" {
    vpc_id = "${aws_vpc.BMO.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1a"

    tags {
        Name = "BMO-public-1-subnet"
    }
}
resource "aws_subnet" "BMO-public-2" {
    vpc_id = "${aws_vpc.BMO.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-1b"

    tags {
        Name = "BMO-public-2-subnet"
    }
}
resource "aws_subnet" "BMO-private-1" {
    vpc_id = "${aws_vpc.BMO.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1a"

    tags {
        Name = "BMO-private-1-subnet"
    }
}
resource "aws_subnet" "BMO-private-2" {
    vpc_id = "${aws_vpc.BMO.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-1b"

    tags {
        Name = "BMO-private-2-subnet"
    }
}

# Internet GW
resource "aws_internet_gateway" "BMO-gw" {
    vpc_id = "${aws_vpc.BMO.id}"

    tags {
        Name = "BMO-GW"
    }
}

# route tables
resource "aws_route_table" "BMO-public" {
    vpc_id = "${aws_vpc.BMO.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.BMO-gw.id}"
    }

    tags {
        Name = "BMO-public-route"
    }
}

# route associations public
resource "aws_route_table_association" "BMO-public-1" {
    subnet_id = "${aws_subnet.BMO-public-1.id}"
    route_table_id = "${aws_route_table.BMO-public.id}"
}
resource "aws_route_table_association" "BMO-public-2" {
    subnet_id = "${aws_subnet.BMO-public-2.id}"
    route_table_id = "${aws_route_table.BMO-public.id}"
}
