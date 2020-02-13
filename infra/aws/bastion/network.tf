module "bastion_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.project_tag}-bastion"

  cidr = "192.168.0.0/16"

  azs             = [data.aws_availability_zones.available.names[0]]
  private_subnets = ["192.168.1.0/24"]
  public_subnets  = ["192.168.101.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

resource "aws_default_security_group" "bastion_default" {
  vpc_id   = module.bastion_vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}