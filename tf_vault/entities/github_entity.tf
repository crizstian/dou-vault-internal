variable "users" {}
variable "policies" {}

variable "enable_github_entity" {
  default = false
}

variable "depends_on_userpass" {}

data "vault_auth_backend" "github" {
  path       = "github"
  depends_on = [var.depends_on_userpass]
}

resource "vault_identity_entity" "entity" {
  count    = var.enable_github_entity ? length(var.users) : 0
  name     = var.users[count.index].entity_name
  policies = var.policies[var.users[count.index].metadata.team]
  metadata = var.users[count.index].metadata

  depends_on = [var.depends_on_userpass]
}


resource "vault_identity_entity_alias" "github" {
  count          = var.enable_github_entity ? length(var.users) : 0
  name           = var.users[count.index].github_user
  mount_accessor = data.vault_auth_backend.github.accessor
  canonical_id   = vault_identity_entity.entity[count.index].id

  depends_on = [var.depends_on_userpass]
}