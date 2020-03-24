variable "admins_members" {}
variable "enable_admins_group" {
    default = false
}

resource "vault_identity_group" "admin" {
  count =  var.enable_admins_group ? 1 : 0

  name              = "admin"
  type              = "internal"
  policies          = var.policies.admin
  member_entity_ids = var.admins_members

  metadata = {
    organization = "DigitalOnUs"
    team         = "admin"
  }
}