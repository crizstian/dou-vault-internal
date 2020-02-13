data "aws_availability_zones" "available" {
  state    = "available"
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key" {
  sensitive_content = tls_private_key.ssh.private_key_pem
  filename          = "${path.module}/${var.project_tag}-key.pem"
  file_permission   = "0400"
}

resource "aws_key_pair" "key" {
  key_name   = "${var.project_tag}-key"
  public_key = tls_private_key.ssh.public_key_openssh
}

data "aws_ami" "latest-image" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.latest-image.id
  instance_type = "t2.micro"
  subnet_id     = module.bastion_vpc.public_subnets[0]
  key_name      = aws_key_pair.key.key_name

  tags = var.tags
}