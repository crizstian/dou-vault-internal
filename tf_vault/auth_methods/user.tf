variable "enable_userpass" {
  default = false
}

resource "vault_auth_backend" "userpass" {
  count = var.enable_userpass ? 1 : 0
  type  = "userpass"
}


resource "null_resource" "depends" {
  depends_on = [vault_auth_backend.userpass]
}

output "depends_on_userpass" {
    value = null_resource.depends.id
}

output "userpass_accessor" {
  value = var.enable_userpass ? vault_auth_backend.userpass[0].accessor : ""
}

