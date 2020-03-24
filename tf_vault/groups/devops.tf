variable "devops_members" {}
variable "enable_devops_group" {
    default = false
}

resource "vault_identity_group" "devops" {
  count =  var.enable_devops_group ? 1 : 0

  name              = "devops"
  type              = "internal"
  policies          = var.policies.devops
  member_entity_ids = var.devops_members

  metadata = {
    organization = "DigitalOnUs"
    team         = "devops"
  }
}