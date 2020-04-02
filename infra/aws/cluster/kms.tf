# AWS S3 Bucket for Certificates, Private Keys, Encryption Key, and License
resource "aws_kms_key" "bucketkms" {
  description             = "${var.project_tag}-key"
  deletion_window_in_days = 7
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