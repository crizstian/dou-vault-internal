variable "depends_on_userpass" {}

variable "users" {}

variable "admins" {}

variable "policies" {}

resource "random_pet" "console_password_admin" {
  count  =  length(var.admins)
  length = 3
}

resource "random_pet" "console_password_user" {
  count  = length(var.users)
  length = 3
}

resource "vault_generic_endpoint" "admin" {
  count      = length(var.admins)
  depends_on = [var.depends_on_userpass]

  path                 = "auth/userpass/users/${var.admins[count.index].entity_name}"
  ignore_absent_fields = true
  data_json            = <<EOT
{
  "policies": ${jsonencode(concat(var.policies[var.admins[count.index].metadata.team], ["admin"]))},
  "password": "${random_pet.console_password_admin[count.index].id}"
}
EOT
}

resource "vault_generic_endpoint" "user" {
  count      = length(var.users)
  depends_on = [var.depends_on_userpass]
  
  path                 = "auth/userpass/users/${var.users[count.index].entity_name}"
  ignore_absent_fields = true
  data_json            = <<EOT
{
  "policies": ${jsonencode(var.policies[var.users[count.index].metadata.team])},
  "password": "${random_pet.console_password_user[count.index].id}"
}
EOT
}
