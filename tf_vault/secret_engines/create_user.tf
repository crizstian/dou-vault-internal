variable "depends_on_userpass" {}

variable "users" {}

variable "user_policies" {}

variable "admins" {}

variable "admin_policies" {}


resource "vault_generic_endpoint" "admin" {
  count = length(var.admins)
  depends_on           = [var.depends_on_userpass]
  path                 = "auth/userpass/users/${var.admins[count.index].name}"
  ignore_absent_fields = true
  data_json            = <<EOT
{
  "policies": ${jsonencode(var.admin_policies)},
  "password": "${var.admins[count.index].password}"
}
EOT
}

resource "vault_generic_endpoint" "user" {
  count = length(var.users)
  depends_on           = [var.depends_on_userpass]
  path                 = "auth/userpass/users/${var.users[count.index].name}"
  ignore_absent_fields = true
  data_json            = <<EOT
{
  "policies": ${jsonencode(var.user_policies)},
  "password": "${var.users[count.index].password}"
}
EOT
}
