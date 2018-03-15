# Internet VPC
resource "aws_vpc" "aurora" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "aurora vpc"
    }
}


# Subnets
resource "aws_subnet" "aurora-public-1" {
    vpc_id = "${aws_vpc.aurora.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1a"

    tags {
        Name = "aurora-public-1"
    }
}
resource "aws_subnet" "aurora-public-2" {
    vpc_id = "${aws_vpc.aurora.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1b"

    tags {
        Name = "aurora-public-2"
    }
}
resource "aws_subnet" "aurora-public-3" {
    vpc_id = "${aws_vpc.aurora.id}"
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "eu-central-1c"

    tags {
        Name = "aurora-public-3"
    }
}
resource "aws_subnet" "aurora-private-1" {
    vpc_id = "${aws_vpc.aurora.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1a"

    tags {
        Name = "aurora-private-1"
    }
}
resource "aws_subnet" "aurora-private-2" {
    vpc_id = "${aws_vpc.aurora.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1b"

    tags {
        Name = "aurora-private-2"
    }
}
resource "aws_subnet" "aurora-private-3" {
    vpc_id = "${aws_vpc.aurora.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "eu-central-1c"

    tags {
        Name = "aurora-private-3"
    }
}

# Internet GW
resource "aws_internet_gateway" "aurora-gw" {
    vpc_id = "${aws_vpc.aurora.id}"

    tags {
        Name = "aurora"
    }
}

# route tables
resource "aws_route_table" "aurora-public" {
    vpc_id = "${aws_vpc.aurora.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.aurora-gw.id}"
    }

    tags {
        Name = "aurora-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "aurora-public-1-a" {
    subnet_id = "${aws_subnet.aurora-public-1.id}"
    route_table_id = "${aws_route_table.aurora-public.id}"
}
resource "aws_route_table_association" "aurora-public-2-a" {
    subnet_id = "${aws_subnet.aurora-public-2.id}"
    route_table_id = "${aws_route_table.aurora-public.id}"
}
resource "aws_route_table_association" "aurora-public-3-a" {
    subnet_id = "${aws_subnet.aurora-public-3.id}"
    route_table_id = "${aws_route_table.aurora-public.id}"
}
