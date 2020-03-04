variable "enable_kv_engine" {
  default = false
}
variable "enable_kv_v2_engine" {
  default = false
}
variable "enable_aws_engine" {
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
  aws   = var.enable_aws_engine ? [{type = "aws", path = "aws", description = "aws engine"}] : []

  engines = concat(
    local.kv,
    local.kv-v2,
    local.aws
  )
}

resource "null_resource" "depends_on" {
  depends_on = [vault_mount.engines]
}

output "depends_on" {
  value = null_resource.depends_on.id
}