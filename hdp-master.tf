resource "aws_instance" "hdp-master" {
  ami = "${data.aws_ami.centos.id}"
  count = "${var.hdp-master_instance_count}"

  private_ip = "${cidrhost(element(aws_subnet.hdp-private.*.cidr_block, count.index), var.hdp-master_start_ip + count.index)}"

  instance_type = "${var.hdp-master_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]
  subnet_id = "${element(aws_subnet.hdp-private.*.id, count.index)}"
  associate_public_ip_address = false
  key_name = "terraform"
  user_data = <<EOF
#cloud-config
hostname: hdp-master-${count.index +1}
fqdn: hdp-master-${count.index +1}.${var.domain}
EOF

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
    Name = "hdp-master-${count.index + 1}"
  }

}
