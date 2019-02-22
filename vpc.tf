resource "aws_vpc" "hdp" {
  enable_dns_hostnames = true
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "hdp"
  }
}

#resource "aws_vpc_dhcp_options" "hdp" {
#  domain_name = "hdptest.net"
#  domain_name_servers = [ "10.0.10.60", "8.8.8.8, 8.8.4.4" ]
#}

#resource "aws_vpc_dhcp_options_association" "hdp" {
#  vpc_id = "${aws_vpc.hdp.id}"
#  dhcp_options_id = "${aws_vpc_dhcp_options.hdp.id}"
#}

resource "aws_internet_gateway" "hdp" {
  vpc_id = "${aws_vpc.hdp.id}"

  tags {
    Name = "hdp-ig"
  }

}

resource "aws_security_group" "ambari_access" {
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ambari_access"
  }

  vpc_id = "${aws_vpc.hdp.id}"
}

resource "aws_security_group" "default_cluster_access" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "default_cluster_access"
  }

  vpc_id = "${aws_vpc.hdp.id}"
}

resource "aws_subnet" "hdp-subnet" {
  vpc_id = "${aws_vpc.hdp.id}"

  cidr_block = "${var.subnet_cidr}"
  availability_zone = "${var.aws_az}"

  tags {
    Name = "hdp-subnet"
  }
}

resource "aws_subnet" "db1-subnet" {
  vpc_id = "${aws_vpc.hdp.id}"

  cidr_block = "${var.db1_subnet_cidr}"
  availability_zone = "${var.db1_az}"

  tags {
    Name = "db1-subnet"
  }
}

resource "aws_subnet" "db2-subnet" {
  vpc_id = "${aws_vpc.hdp.id}"

  cidr_block = "${var.db2_subnet_cidr}"
  availability_zone = "${var.db2_az}"

  tags {
    Name = "db2-subnet"
  }
}

resource "aws_route_table" "hdp-route" {
  vpc_id = "${aws_vpc.hdp.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.hdp.id}"
  }

  tags {
    Name = "Default route"
  }
}
   
resource "aws_route_table_association" "hdp" {
  subnet_id = "${aws_subnet.hdp-subnet.id}"
  route_table_id = "${aws_route_table.hdp-route.id}"

}
