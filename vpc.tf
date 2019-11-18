resource "aws_vpc" "hdp" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "hdp-vpc"
    }
}

resource "aws_subnet" "hdp-private" {
    count = length(var.private_subnets)
    vpc_id = aws_vpc.hdp.id
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.azs.names[count.index]
    cidr_block = element(var.private_subnets, count.index)

    tags = {
        Name = "hdp-private-sub${count.index}"
    }
}

resource "aws_subnet" "hdp-public" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.hdp.id
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.azs.names[count.index]
    cidr_block = element(var.public_subnets, count.index)

    tags = {
        Name = "hdp-public-sub${count.index}"
    }
}

resource "aws_subnet" "hdp-rds" {
    count = length(var.rds_subnets)
    vpc_id = aws_vpc.hdp.id
    map_public_ip_on_launch = "false"
    availability_zone = data.aws_availability_zones.azs.names[count.index]
    cidr_block = element(var.rds_subnets, count.index)

    tags = {
        Name = "hdp-rds-sub${count.index}"
    }
}

resource "aws_internet_gateway" "hdp-igw" {
    vpc_id = aws_vpc.hdp.id

    tags = {
        Name = "hdp-igw"
    }
}

resource "aws_route_table" "hdp-public" {
    vpc_id = aws_vpc.hdp.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.hdp-igw.id
    }
    tags = {
        Name = "hdp-public-rt"
    }
}

resource "aws_route_table_association" "hdp-public" {
    count = length(var.public_subnets)
    subnet_id = element(aws_subnet.hdp-public.*.id, count.index)
    route_table_id = aws_route_table.hdp-public.id
}

resource "aws_eip" "hdp-nat" {
    count = length(var.public_subnets)
    vpc = true

    tags = {
        Name = "hdp-nat-eip${count.index}"
    }
}

resource "aws_nat_gateway" "hdp-nat-gw" {
    count = length(var.public_subnets)
    allocation_id = element(aws_eip.hdp-nat.*.id, count.index)
    subnet_id = element(aws_subnet.hdp-public.*.id, count.index)

    tags = {
        Name = "hdp-nat-gw${count.index}"
    }
}

resource "aws_route_table" "hdp-private-rt" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.hdp.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.hdp-nat-gw.*.id, count.index)
    }

    tags = {
        Name = "hdp-private-rt${count.index}"
    }
}

resource "aws_route_table_association" "hdp-private" {
    count = length(var.private_subnets)
    subnet_id = element(aws_subnet.hdp-private.*.id, count.index)
    route_table_id = element(aws_route_table.hdp-private-rt.*.id, count.index)
}
