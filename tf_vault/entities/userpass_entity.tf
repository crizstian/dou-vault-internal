variable "enable_userpass_entity" {
  default = false
}

data "vault_auth_backend" "userpass" {
  path       = "userpass"
  depends_on = [var.depends_on_userpass]
}

resource "vault_identity_entity_alias" "userpass" {
  count          = var.enable_userpass_entity ? length(var.users) : 0
  name           = var.users[count.index].entity_name
  mount_accessor = data.vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.entity[count.index].id

  depends_on = [var.depends_on_userpass]
}
