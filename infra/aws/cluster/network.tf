data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.project_tag}-vpc"

  cidr = "10.${var.subnet_second_octet}.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets = ["10.${var.subnet_second_octet}.1.0/24", "10.${var.subnet_second_octet}.2.0/24", "10.${var.subnet_second_octet}.3.0/24"]
  public_subnets  = ["10.${var.subnet_second_octet}.101.0/24", "10.${var.subnet_second_octet}.102.0/24", "10.${var.subnet_second_octet}.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.tags
}

resource "aws_default_security_group" "primary_cluster" {
  vpc_id   = module.vpc.vpc_id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8200
    to_port     = 8200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
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