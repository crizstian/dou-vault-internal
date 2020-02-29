variable "path" {
  default = "secret"
}
variable "type" {
  default = "kv"
}
variable "description" {
  default = "Secret KV Engine"
}
variable "enable_kv_engine" {
  default = false
}

resource "vault_mount" "secret-kv" {
  count = var.enable_kv_engine ? 1 : 0

  path        = var.path       
  type        = var.type       
  description = var.description
}

resource "vault_generic_secret" "example" {
  count = var.enable_kv_engine ? 1 : 0

  path      = "secret/test"
  data_json = <<EOT
    {
      "foo":   "bar",
      "pizza": "cheese"
    }
  EOT
}