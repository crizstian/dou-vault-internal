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
    "policies": ${jsonencode(sort(var.policies))},
    "password": "${random_pet.console_password_user[count.index].id}"
  }
  EOT
}