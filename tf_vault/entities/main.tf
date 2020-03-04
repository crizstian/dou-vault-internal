variable "entities" {}

variable "enable_identity_entity" {
  default = false
}

variable "depends_on_userpass" {}

data "vault_auth_backend" "github" {
  path       = "github"
  depends_on = [var.depends_on_userpass]
}

data "vault_auth_backend" "userpass" {
  path       = "userpass"
  depends_on = [var.depends_on_userpass]
}


resource "vault_identity_entity" "entity" {
  count    = var.enable_identity_entity ? length(var.entities) : 0
  name     = var.entities[count.index].name
  policies = var.entities[count.index].policies
  metadata = var.entities[count.index].metadata

  depends_on = [var.depends_on_userpass]
}


resource "vault_identity_entity_alias" "github" {
  count          = var.enable_identity_entity ? length(var.entities) : 0
  name           = var.entities[count.index].github_user
  mount_accessor = data.vault_auth_backend.github.accessor
  canonical_id   = vault_identity_entity.entity[count.index].id

  depends_on = [var.depends_on_userpass]
}


resource "vault_identity_entity_alias" "userpass" {
  count          = var.enable_identity_entity ? length(var.entities) : 0
  name           = var.entities[count.index].userpass
  mount_accessor = data.vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.entity[count.index].id

  depends_on = [var.depends_on_userpass]
}
