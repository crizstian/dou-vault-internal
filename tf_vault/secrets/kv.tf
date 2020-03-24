variable "enable_kv_engine" {
  default = false
}
variable "enable_kv_v2_engine" {
  default = false
}

resource "vault_mount" "engines" {
  count = var.enable_kv_engine ? length(local.engines) : 0

  path        = local.engines[count.index].path       
  type        = local.engines[count.index].type       
  description = local.engines[count.index].description
}

locals {
  kv    = var.enable_kv_engine ? [{type = "kv", path = "secret", description = "kv engine"}] : []
  kv-v2 = var.enable_kv_v2_engine ? [{type = "kv-v2", path = "kv-v2", description = "kv-v2 engine"}] : []

  engines = concat(
    local.kv,
    local.kv-v2,
  )
}

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

  depends_on = [vault_mount.engines]
}