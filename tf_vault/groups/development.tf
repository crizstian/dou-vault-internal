variable "development_members" {}
variable "enable_development_group" {
    default = false
}

resource "vault_identity_group" "development" {
  count =  var.enable_development_group ? 1 : 0

  name              = "development"
  type              = "internal"
  policies          = var.policies.development
  member_entity_ids = var.development_members

  metadata = {
    organization = "DigitalOnUs"
    team         = "development"
  }
}