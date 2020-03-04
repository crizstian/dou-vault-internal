variable "depends_on_generic_endpoints" {}

variable "users" {}

variable "policies" {}

resource "random_pet" "console_password_user" {
  count  = length(var.users)
  length = 3
}

resource "vault_generic_endpoint" "user" {
  count      = length(var.users)
  depends_on = [var.depends_on_generic_endpoints]

  path                 = "auth/userpass/users/${var.users[count.index].entity_name}"
  ignore_absent_fields = true
  data_json            = <<EOT
  {
    "policies": ${jsonencode(lookup(var.users[count.index], "is_admin", false) ? sort(concat(["admin"], var.policies[local.users_team[count.index]])) : sort(var.policies[local.users_team[count.index]]))},
    "password": "${random_pet.console_password_user[count.index].id}"
  }
  EOT
}

locals {
  users_team = var.users.*.metadata.team
}