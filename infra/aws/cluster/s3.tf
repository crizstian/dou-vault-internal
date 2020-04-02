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
  bucket        = "${var.project_tag}-consul-backups"
  force_destroy = var.force_bucket_destroy
  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}

resource "null_resource" "tls" {
  count = length(var.tls_files)

  provisioner "local-exec" {
    command = "echo '${var.tls_files[count.index].file}' > '${path.cwd}/tls/${var.tls_files[count.index].name}'"
  }
}

resource "aws_s3_bucket_object" "object1" {
  depends_on = [
    null_resource.tls,
    aws_s3_bucket.consul_backups,
  ]

  count = length(var.tls_files)

  bucket = "${var.project_tag}-consul-setup"
  key    = var.tls_files[count.index].name
  source = "${path.cwd}/tls/${var.tls_files[count.index].name}"
}