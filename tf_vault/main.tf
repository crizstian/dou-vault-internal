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
  github_token_policies = ["default"]

  //Userspass will not be enabled this is for testing purposes
  enable_userpass = true
}

module "secret_engines" {
  source = "./secret_engines"

  depends_on_userpass = module.auth_methods.depends_on_userpass
  enable_kv_engine    = true

  //Userspass will not be enabled this is for testing purposes
  users    = var.dou_users
  policies = module.policies.list_of_policies
}

module "entities" {
  source = "./entities"

  enable_github_entity   = true
  enable_userpass_entity = true
  users                  = var.dou_users
  policies               = module.policies.list_of_policies
  userpass_accessor      = module.auth_methods.userpass_accessor
  github_accessor        = module.auth_methods.github_accessor
}
