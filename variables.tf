variable "aws_region" {
  default = "ca-central-1"
}

variable "ssh_key" {
  default = "terraform"
}

data "aws_ami" "centos" {
owners      = ["679593333241"]
most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

variable "hdp-ipa_instance_count" {
  default = 0
}

variable "hdp-ipa_instance_type" {
  default = "t2.small"
}

variable "hdp-edge_instance_count" {
  default = 0
}

variable "hdp-edge_instance_type" {
  default = "r4.xlarge"
}

variable "hdp-master_instance_count" {
  default = 0
}

variable "hdp-master_instance_type" {
  default = "r4.xlarge"
}

variable "hdp-worker_instance_count" {
  default = 0
}

variable "hdp-worker_instance_type" {
  default = "r4.xlarge"
}

variable "hdf-management_instance_count" {
  default = 0
}

variable "hdf-management_instance_type" {
  default = "r4.xlarge"
}

variable "hdf-edge_instance_count" {
  default = 0
}

variable "hdf-edge_instance_type" {
  default = "r4.xlarge"
}

variable "hdf-worker_instance_count" {
  default = 0
}

variable "hdf-worker_instance_type" {
  default = "r4.xlarge"
}

variable "hdf-dp_instance_count" {
  default = 0
}

variable "hdf-dp_instance_type" {
  default = "r4.xlarge"
}

data "aws_availability_zones" "azs" {
}

variable "private_subnets" {
  default = [ "10.0.10.0/24", "10.0.20.0/24" ]
}

variable "public_subnets" {
  default = [ "10.0.100.0/24", "10.0.200.0/24" ]
}

variable "rds_subnets" {
  default = [ "10.0.60.0/24", "10.0.70.0/24" ]
}

variable "hdp-ipa_start_ip" {
  default = "5"
}

variable "hdp-edge_start_ip" {
  default = "10"
}

variable "hdp-master_start_ip" {
  default = "20"
}

variable "hdp-worker_start_ip" {
  default = "30"
}

variable "hdf-management_start_ip" {
  default = "40"
}

variable "hdf-worker_start_ip" {
  default = "50"
}

variable "hdf-edge_start_ip" {
  default = "20"
}

variable "hdf-dp_start_ip" {
  default = "60"
}

variable "domain" {
  default = "cldropsrv.com"
}

variable "cluster" {
  default = "hdptest"
}

variable "rds_db_count" {
  default = "0"
}

variable "rds_username" {
  default = "hdpdbuser"
}

variable "rds_password" {
  default = "hdpdbpass"
}

variable "rds_instance_type" {
  default = "db.t2.medium"
}
