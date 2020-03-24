variable "users" {}
variable "policies" {}

variable "enable_github_entity" {
  default = false
}

variable "github_accessor" {}

resource "vault_identity_entity" "entity" {
  count    = var.enable_github_entity ? length(var.users) : 0
  name     = var.users[count.index].entity_name
  policies = var.policies
  metadata = var.users[count.index].metadata
}


resource "vault_identity_entity_alias" "github" {
  count          = var.enable_github_entity ? length(var.users) : 0
  name           = var.users[count.index].github_user
  mount_accessor = var.github_accessor
  canonical_id   = vault_identity_entity.entity[count.index].id
}

locals {
  development_members = [for key, user in vault_identity_entity.entity :  user.id if user.metadata.team=="devops"]
  devops_members      = [for key, user in vault_identity_entity.entity :  user.id if user.metadata.team=="development"]
  admins_members      = [for key, user in vault_identity_entity.entity :  user.id if user.metadata.is_admin=="true"]
}

output "devops" {
  value = local.devops_members
}

output "development" {
  value = local.development_members
}

output "admins" {
  value = local.admins_members
}