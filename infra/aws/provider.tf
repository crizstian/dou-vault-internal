provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region1
}

terraform {
  backend "consul" {
    address = "vault.douvault.com:8500"
    scheme  = "https"
    path    = "terraform/infra/aws/vault.tfstate"
  }
}