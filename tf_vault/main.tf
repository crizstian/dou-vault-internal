module "policies" {
  source = "./policies"

  enable_entity_policy      = true
  enable_admin_policy       = true
  enable_devops_policy      = true
  enable_development_policy = true
}

module "auth_methods" {
  source = "./auth_methods"

  enable_github         = true
  github_token_policies = ["default"]

  //Userspass will not be enabled this is for testing purposes
  enable_userpass = true
}

module "secret_engines" {
  source = "./backend"

  enable_kv_engine    = true
  enable_kv_v2_engine = true
  enable_aws_engine   = true
}

module "generic_endpoints" {
  source     = "./generic_endpoints"

  depends_on_generic_endpoints = module.auth_methods.depends_on_userpass

  users    = var.dou_users
  policies = module.policies.list_of_policies
}

module "entities" {
  source     = "./entities"
  
  depends_on_entities = module.auth_methods.depends_on_userpass

  enable_github_entity   = true
  enable_userpass_entity = true

  //Userspass will not be enabled this is for testing purposes
  userpass_accessor      = module.auth_methods.userpass_accessor
  github_accessor        = module.auth_methods.github_accessor
  
  users                  = var.dou_users
  policies               = module.policies.list_of_policies
}

module "secrets" {
  source     = "./secrets"
  
  depends_on_secrets = [module.secret_engines.depends_on]
  
  enable_test_secret = true
}