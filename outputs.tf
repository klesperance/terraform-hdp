output "endpoint" {
  value = "${aws_db_instance.hdp.*.endpoint}"
}

output "hdp-edges" {
  value = ["${aws_instance.hdp-edge.*.public_ip}"]
}

output "hdf-edges" {
  value = ["${aws_instance.hdf-edge.*.public_ip}"]
}

output "hdpmn_ips" {
  value = ["${aws_instance.hdp-master.*.private_ip}"]
}

output "hdpdn_ips" {
  value = ["${aws_instance.hdp-worker.*.private_ip}"]
}

output "hdpen_ips" {
  value = ["${aws_instance.hdp-edge.*.private_ip}"]
}
