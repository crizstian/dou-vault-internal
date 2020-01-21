# provider "aws" {
#   region     = var.aws_region
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
# }

provider "vault" {
  address = "https://vault.douvault.com"
  token   = var.vault_token
  skip_tls_verify = true
}

resource "vault_aws_secret_backend" "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  path       = var.aws_vault_path
}

# terraform {
#  backend "s3" {
#   encrypt = true
#   bucket  = var.aws_s3_bucket
#   region  = var.aws_region
#   key     = "terraform-state/terraform.tfstate"
#  }
# }

# resource "aws_s3_bucket" "douvault" {
#   bucket = var.aws_s3_bucket

#   versioning {
#     enabled = true
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }