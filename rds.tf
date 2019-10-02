resource "aws_db_subnet_group" "hdpdb" {
  name = "hdpdb"
  subnet_ids = ["${aws_subnet.hdp-rds.0.id}", "${aws_subnet.hdp-rds.1.id}"]

  tags = {
    Name = "HDP DB Subnet Group"
  }
}

resource "aws_db_instance" "hdp" {
  count = "${var.rds_db_count}"
  allocated_storage = 20
  storage_type = "gp2"
  engine = "${var.rds_engine}"
  engine_version = "${var.rds_engine_version}"
  instance_class = "${var.rds_instance_type}"
  identifier = "hdp"
  username = "${var.rds_username}"
  password = "${var.rds_password}"
  db_subnet_group_name = "${aws_db_subnet_group.hdpdb.name}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]
  skip_final_snapshot = true

  tags = {
    Name = "HDP DB Instance"
  }

}
