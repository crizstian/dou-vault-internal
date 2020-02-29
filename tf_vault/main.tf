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

module "policies" {
  source = "./policies"

  enable_templated_policy = true
}

module "auth_methods" {
  source = "./auth_methods"

  enable_github         = true
  github_token_policies = ["default", "user"]
}

module "secret_engines" {
  source = "./secret_engines"

  enable_kv_engine = true
}