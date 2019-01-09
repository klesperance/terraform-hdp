resource "aws_db_subnet_group" "hdpdb" {
  name = "hdpdb"
  subnet_ids = ["${aws_subnet.db1-subnet.id}", "${aws_subnet.db2-subnet.id}"]

  tags {
    Name = "HDP DB Subnet Group"
  }
}

resource "aws_db_instance" "hdp" {
  count = "${var.db_count}"
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mariadb"
  engine_version = "10.2.15"
  instance_class = "db.t2.micro"
  identifier = "hdp"
  username = "${var.rds_username}"
  password = "${var.rds_password}"
  db_subnet_group_name = "${aws_db_subnet_group.hdpdb.name}"
  vpc_security_group_ids = ["${aws_security_group.default_cluster_access.id}"]
  skip_final_snapshot = true

  tags {
    Name = "HDP DB Instance"
  }

}
