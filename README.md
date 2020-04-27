# terraform-hdp

Just some terraform code to build infrastructure for HDP/HDF clusters

- aws.tf - Just your typical AWS provider
- hdf-dp.tf - This will build a Data Plane instance.
- hdf-edge.tf - This will build HDF Edge Nodes
- hdf-management.tf - This will build HDF Management Nodes
- hdf-worker.tf - This will build HDF Worker Nodes
- hdp-edge.tf - This will build HDP Edge Nodes
- hdp-ipa.tf - This will deploy an IPA Server
- hdp-master.tf - This will deploy HDP Master Nodes
- hdp-worker.tf - This will deploy HDP Worker Nodes
- outputs.tf - This will output the RDS Endpoint, and the Public IP Address of any Edge nodes
- rds.tf - This will build a MariaDB RDS Instance
- security.tf - This will configure AWS Security Groups
- variables.tf - Variables - override the defaults with a .tfvars file
- vpc.tf - This creates the VPC with appropriate subnets, an internet gateway, NAT gateways, and a route table

Once the infrastructure has been built, you could use something like the [ansible-hortonworks](https://github.com/hortonworks/ansible-hortonworks) collection of playbooks (with a static inventory!) to build an HDP or HDF cluster.

Example terraform.tfvars:

```
hdp-ipa_instance_count = 1
hdp-edge_instance_count = 2
hdp-master_instance_count = 4
hdp-worker_instance_count = 6
hdf-edge_instance_count = 2
hdf-management_instance_count = 3
hdf-worker_instance_count = 3
rds_db_count = 1
hdf-dp_instance_count = 1
ssh_access_cidr = "1.2.3.4/32,2.3.4.0/24"
```

Please be sure to update `ssh_access_cidr`, otherwise your cluster edge nodes will be wide open to the internet.
