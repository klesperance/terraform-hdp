resource "aws_instance" "hdp-edge" {
  ami = data.aws_ami.centos.id
  count = var.hdp-edge_instance_count

  private_ip = cidrhost(element(aws_subnet.hdp-public.*.cidr_block, count.index), var.hdp-edge_start_ip + count.index)

  instance_type = var.hdp-edge_instance_type
  vpc_security_group_ids = [aws_security_group.default_cluster_access.id]
  subnet_id = element(aws_subnet.hdp-public.*.id, count.index)
  associate_public_ip_address = true
  key_name = var.ssh_key
  user_data = <<EOF
#cloud-config
hostname: hdp-edge-${count.index +1}
fqdn: hdp-edge-${count.index +1}.${var.cluster}.${var.domain}
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

  tags = {
    Name = "hdp-edge-${count.index + 1}.${var.cluster}"
    Owner = var.owner
  }

}
