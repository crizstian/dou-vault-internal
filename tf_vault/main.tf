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
  github_token_policies = ["default", "github"]

  # Userspass will not be enabled this is for testing purposes
  enable_userpass = true
}

module "secret_engines" {
  source = "./backend"

  enable_kv_engine    = true
  enable_kv_v2_engine = true
}

module "generic_endpoints" {
  source     = "./generic_endpoints"

  depends_on_generic_endpoints = module.auth_methods.depends_on_userpass

  users    = var.dou_users
  policies = module.policies.list_of_policies
}

module "entities" {
  source     = "./entities"

  enable_github_entity   = true
  enable_userpass_entity = true

  # Userspass will not be enabled this is for testing purposes
  userpass_accessor      = module.auth_methods.userpass_accessor
  github_accessor        = module.auth_methods.github_accessor

  users                  = var.dou_users
  policies               = ["user"]
}

module "groups" {
  source = "./groups"

  enable_devops_group = true
  devops_members = module.entities.devops
  enable_admins_group = true
  admins_members = module.entities.admins
}

module "secrets" {
  source     = "./secrets"

  depends_on_secrets = [module.secret_engines.depends_on]

  enable_test_secret = true
  enable_aws_dynamic_secret = true

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = "us-east-1"
  aws_roles      = var.aws_roles


  enable_azure_dynamic_secret = true
  azure_subscription_id       = var.azure_subscription_id
  azure_tenant_id             = var.azure_tenant_id
  azure_client_id             = var.azure_client_id
  azure_client_secret         = var.azure_client_secret
  azure_resource_group        = var.azure_resource_group

  enable_gcp_dynamic_secret   = true
  gcp_root_project            = "cramirez-terraform-admin"
}