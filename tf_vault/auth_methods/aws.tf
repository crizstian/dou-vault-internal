resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  path       = "/aws-dou-training"
}