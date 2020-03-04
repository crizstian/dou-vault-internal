variable "depends_on_secrets" {}
variable "enable_test_secret" {}

resource "vault_generic_secret" "example" {
  count = var.enable_test_secret ? 1 : 0

  path      = "secret/test"
  data_json = <<EOT
    {
      "foo":   "bar",
      "pizza": "cheese"
    }
  EOT

  depends_on = [var.depends_on_secrets]
}