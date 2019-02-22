resource "aws_instance" "ipa" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.ipa_count}"

  private_ip = "10.0.10.6${count.index}"

  instance_type = "${var.ipa_type}"
  subnet_id = "${aws_subnet.hdp-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]

  associate_public_ip_address = true
  key_name = "terraform"

  ebs_optimized = false

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
    Name = "ipa-${count.index}"
  }

  depends_on = ["aws_internet_gateway.hdp"]

}
