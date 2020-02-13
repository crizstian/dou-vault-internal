// resource "aws_default_security_group" "primary_cluster" {
//   provider = aws.region1
//   vpc_id   = module.primary_cluster.vpc_id

//   ingress {
//     protocol  = -1
//     self      = true
//     from_port = 0
//     to_port   = 0
//   }

//   ingress {
//     from_port   = 22
//     to_port     = 22
//     protocol    = "tcp"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

//   ingress {
//     from_port   = 8200
//     to_port     = 8200
//     protocol    = "tcp"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

//   ingress {
//     from_port   = 8500
//     to_port     = 8500
//     protocol    = "tcp"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

//   egress {
//     from_port   = 0
//     to_port     = 0
//     protocol    = "-1"
//     cidr_blocks = ["0.0.0.0/0"]
//   }

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