resource "aws_instance" "hdf-management" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdfmn_count}"

  instance_type = "${var.hdfmn_type}"
  subnet_id = "${aws_subnet.hdp-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]

  associate_public_ip_address = true
  key_name = "terraform"

  ebs_optimized = true

  root_block_device { 
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = true
  }

  ebs_block_device { 
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
    encrypted = true
  }

  tags {
    Name = "hdf-management-${count.index}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}

resource "aws_instance" "hdf-worker" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdfwn_count}"

  instance_type = "${var.hdfwn_type}"
  subnet_id = "${aws_subnet.hdp-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]

  associate_public_ip_address = true
  key_name = "terraform"

  ebs_optimized = true

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
    encrypted = true
  }

  tags {
    Name = "hdf-worker-${count.index}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}

resource "aws_instance" "hdf-edge" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdfen_count}"

  instance_type = "${var.hdfen_type}"
  subnet_id = "${aws_subnet.hdp-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]

  associate_public_ip_address = true
  key_name = "terraform"

  ebs_optimized = true

  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = true
  }

  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = true
    encrypted = true
  }

  tags {
    Name = "hdf-edge-${count.index}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}
