output "hdp-edge_public_ips" {
  value = ["${aws_instance.hdp-edge.*.public_ip}"]
}

output "hdf-edge_public_ips" {
  value = ["${aws_instance.hdf-edge.*.public_ip}"]
}

output "hdp-edge_private_ips" {
  value = ["${aws_instance.hdp-edge.*.private_ip}"]
}

output "hdf-edge_private_ips" {
  value = ["${aws_instance.hdf-edge.*.private_ip}"]
}

output "hdp-ipa_ips" {
  value = ["${aws_instance.hdp-ipa.*.private_ip}"]
}

output "hdp-master_private_ips" {
  value = ["${aws_instance.hdp-master.*.private_ip}"]
}

output "hdp-worker_private_ips" {
  value = ["${aws_instance.hdp-worker.*.private_ip}"]
}

output "hdf-management_private_ips" {
  value = ["${aws_instance.hdf-management.*.private_ip}"]
}

output "hdf-worker_private_ips" {
  value = ["${aws_instance.hdf-worker.*.private_ip}"]
}

output "RDS endpoint" {
  value = "${aws_db_instance.hdp.*.endpoint}"
}
