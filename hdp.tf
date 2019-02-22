resource "aws_instance" "hdp-master" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdpmn_count}"

  private_ip = "10.0.10.1${count.index + 1}"

  instance_type = "${var.hdpmn_type}"
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
    Name = "hdp-master-${count.index + 1}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}

resource "aws_instance" "hdp-worker" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdpwn_count}"

  private_ip = "10.0.10.3${count.index + 1}"

  instance_type = "${var.hdpwn_type}"
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
    Name = "hdp-worker-${count.index + 1}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}

resource "aws_instance" "hdp-edge" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdpen_count}"

  private_ip = "10.0.10.2${count.index + 1}"

  instance_type = "${var.hdpen_type}"
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
    Name = "hdp-edge-${count.index + 1}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}
