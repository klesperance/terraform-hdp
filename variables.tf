variable "aws_region" {
  default = "ca-central-1"
}

variable "aws_az" {
  default = "ca-central-1a"
}

variable "db1_az" {
  default = "ca-central-1a"
}

variable "db2_az" {
  default = "ca-central-1b"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.10.0/24"
}

variable "db1_subnet_cidr" {
  default = "10.0.20.0/25"
}

variable "db2_subnet_cidr" {
  default = "10.0.20.128/25"
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

variable "hdpmn_count" {
  default = 0
}

variable "hdpwn_count" {
  default = 0
}

variable "hdpen_count" {
  default = 0
}

variable "hdfmn_count" {
  default = 0
}

variable "hdfdn_count" {
  default = 0
}

variable "hdfen_count" {
  default = 0
}

variable "hdpmn_type" {
  default = "r4.xlarge"
}

variable "hdpwn_type" {
  default = "r4.xlarge"
}

variable "hdpen_type" {
  default = "r4.xlarge"
}

variable "hdfmn_type" {
  default = "r4.xlarge"
}

variable "hdfdn_type" {
  default = "r4.xlarge"
}

variable "hdfen_type" {
  default = "r4.xlarge"
}

variable "rds_username" {
  default = "user"
}

variable "rds_password" {
  default = "password"
}