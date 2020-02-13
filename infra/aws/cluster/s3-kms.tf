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

resource "null_resource" "file1" {
  provisioner "local-exec" {
    command = "echo '${var.tls_files[0]}' > '${path.cwd}/tls/${var.ca_public_key_file_path}'"
  }
}

resource "null_resource" "file2" {
  provisioner "local-exec" {
    command = "echo '${var.tls_files[1]}' > '${path.cwd}/tls/${var.private_key_file_path}'"
  }
}

resource "null_resource" "file3" {
  provisioner "local-exec" {
    command = "echo '${var.tls_files[2]}' > '${path.cwd}/tls/${var.public_key_file_path}'"
  }
}

resource "aws_s3_bucket_object" "object1" {
  depends_on = [
    null_resource.file1,
    aws_s3_bucket.consul_backups,
  ]

  bucket = "${var.project_tag}-consul-setup"
  key    = var.ca_public_key_file_path
  source = "${path.cwd}/tls/${var.ca_public_key_file_path}"
}
resource "aws_s3_bucket_object" "object2" {
  depends_on = [
    null_resource.file2,
    aws_s3_bucket.consul_backups,
  ]

  bucket = "${var.project_tag}-consul-setup"
  key    = var.private_key_file_path
  source = "${path.cwd}/tls/${var.private_key_file_path}"
}
resource "aws_s3_bucket_object" "object3" {
  depends_on = [
    null_resource.file3,
    aws_s3_bucket.consul_backups,
  ]

  bucket = "${var.project_tag}-consul-setup"
  key    = var.public_key_file_path
  source = "${path.cwd}/tls/${var.public_key_file_path}"
}

resource "aws_kms_key" "vault" {
  description             = "Vault unseal key"
  deletion_window_in_days = 10

  tags = {
    Name = "vault-kms-unseal-${var.project_tag}"
  }
}

