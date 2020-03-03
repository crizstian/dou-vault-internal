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

  enable_templated_policy   = true
  enable_admin_policy       = true
  enable_provisioner_policy = true
}

module "auth_methods" {
  source = "./auth_methods"

  enable_github         = true
  github_token_policies = ["default", "user"]

  //Userspass will not be enabled this is for testing purposes
  enable_userpass = true
}

module "secret_engines" {
  source = "./secret_engines"

  depends_on_userpass = module.auth_methods.depends_on_userpass
  enable_kv_engine    = true

  //Userspass will not be enabled this is for testing purposes
  users         = [{ name = "marin", password = "fake" }, { name = "bernardo", password = "fake" }]
  user_policies = ["default", "user"]

  admins         = [{ name = "cristian", password = "fake" }]
  admin_policies = ["default", "admin"]

}
