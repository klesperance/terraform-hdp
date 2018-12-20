# terraform-hdp

Just some terraform code to build infrastructure for HDP/HDF clusters

-aws.tf - Just your typical AWS provider
-db.tf - This will create an RDS Maria DB instance
-hdf.tf - This will build HDF Management, Worker and Edge nodes
-hdp.tf - This will build HDP Master, Worker and Edge nodes
-outputs.tf - This will output the RDS Endpoint, and the Public IP Address of any Edge nodes
-variables.tf - Variables - override the defaults with a .tfvars file
-vpc.tf - This creates the VPC with appropriate subnets, an internet gateway, security groups, and a route table

Once the infrastructure has been built, you could use something like the [ansible-hortonworks](https://github.com/hortonworks/ansible-hortonworks) to build an HDP or HDF cluster.
