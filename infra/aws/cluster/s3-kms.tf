# AWS S3 Bucket for Certificates, Private Keys, Encryption Key, and License
resource "aws_kms_key" "bucketkms" {
  description             = "${var.project_tag}-key"
  deletion_window_in_days = 7
  # Add deny all policy to kms key to ensure accessing secrets
  # is a break-glass proceedure
  #  policy                  = "arn:aws:iam::aws:policy/AWSDenyAll"
  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

resource "aws_s3_bucket" "consul_setup" {
  bucket        = "${var.project_tag}-consul-setup"
  acl           = "private"
  force_destroy = var.force_bucket_destroy
  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

# AWS S3 Bucket for Consul Backups
resource "aws_s3_bucket" "consul_backups" {
  count         = 1
  bucket        = "${var.project_tag}-consul-backups"
  force_destroy = var.force_bucket_destroy
  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

resource "aws_kms_key" "vault" {
  description             = "Vault unseal key"
  deletion_window_in_days = 10

  tags = {
    Name = "vault-kms-unseal-${var.project_tag}"
  }
}