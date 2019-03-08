resource "aws_security_group" "ambari_access" {
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "hdp-ambari_access"
  }

  vpc_id = "${aws_vpc.hdp.id}"
}

resource "aws_security_group" "default_cluster_access" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["192.175.27.2/32","69.41.198.118/32","65.23.12.218/32"]
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
    Name = "hdp-default_cluster_access"
  }

  vpc_id = "${aws_vpc.hdp.id}"
}
