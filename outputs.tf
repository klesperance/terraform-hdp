output "endpoint" {
  value = "${aws_db_instance.hdp.endpoint}"
}

output "hdp-edges" {
  value = ["${aws_instance.hdp-edge.*.public_ip}"]
}

output "hdf-edges" {
  value = ["${aws_instance.hdf-edge.*.public_ip}"]
}
