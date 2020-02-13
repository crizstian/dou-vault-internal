# If you want to deploy a bastion host to connect to the cluster; then enable this module

// module "bastion" {
//   source = "./bastion"

//   project_tag = random_id.project_tag.hex
//   tags        = var.tags
// }

// resource "aws_route" "bastion_vpc" {
//   provider                  = aws.region1
//   count                     = length(setproduct(module.primary_cluster.public_subnets_cidr_blocks, module.bastion_vpc.public_route_table_ids))
//   route_table_id            = element(setproduct(module.primary_cluster.public_subnets_cidr_blocks, module.bastion_vpc.public_route_table_ids), count.index)[1]
//   destination_cidr_block    = element(setproduct(module.primary_cluster.public_subnets_cidr_blocks, module.bastion_vpc.public_route_table_ids), count.index)[0]
//   vpc_peering_connection_id = aws_vpc_peering_connection.bastion_connectivity.id
// }

// resource "aws_route" "vpc_bastion" {
//   provider                  = aws.region1
//   count                     = length(setproduct(module.bastion_vpc.public_subnets_cidr_blocks, module.primary_cluster.route_tables))
//   route_table_id            = element(setproduct(module.bastion_vpc.public_subnets_cidr_blocks, module.primary_cluster.route_tables), count.index)[1]
//   destination_cidr_block    = element(setproduct(module.bastion_vpc.public_subnets_cidr_blocks, module.primary_cluster.route_tables), count.index)[0]
//   vpc_peering_connection_id = aws_vpc_peering_connection.bastion_connectivity.id
// }