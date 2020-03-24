variable "enable_transit_secret" {}
variable "transit_groups_key" {}

resource "vault_mount" "transit" {
  count = var.enable_transit_secret ? 1 : 0
  
  path                      = "transit"
  type                      = "transit"
  description               = "Encryption as a Service"
  default_lease_ttl_seconds = 3600
  max_lease_ttl_seconds     = 86400
}

resource "vault_transit_secret_backend_key" "key" {
  count = var.enable_transit_secret ? length(var.transit_groups_key) : 0

  backend          = vault_mount.transit[0].path
  name             = var.transit_groups_key[count.index]
  deletion_allowed = true
}