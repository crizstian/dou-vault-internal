variable "vault_address" {
  default = "https://vault.douvault.com:8200"
}
variable "skip_tls_verify" {
  default = false
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "vault" {
  address         = var.vault_address
  skip_tls_verify = var.skip_tls_verify
}

terraform {
  backend "consul" {
    address = "vault.douvault.com:8500"
    scheme  = "https"
    path    = "terraform/vault.state"
  }
}