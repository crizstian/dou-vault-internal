variable "enable_userpass_entity" {
  default = false
}

variable "userpass_accessor" {}

resource "vault_identity_entity_alias" "userpass" {
  count          = var.enable_userpass_entity ? length(var.users) : 0
  name           = var.users[count.index].entity_name
  mount_accessor = var.userpass_accessor
  canonical_id   = vault_identity_entity.entity[count.index].id
}
