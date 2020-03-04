variable "enable_devops_policy" {
  default = false
}

variable "enable_development_policy" {
  default = false
}

resource "vault_policy" "group" {
  count = var.enable_devops_policy ? length(local.policies) : 0

  name   = local.policies[count.index]
  policy = <<EOT
    # Grant permissions on the group specific path
    # The env is specified in the group metadata
    path "group-kv/data/${local.policies[count.index]}/{{identity.groups.names.${local.policies[count.index]}.metadata.env}}/*" {
        capabilities = [ "create", "update", "read", "delete", "list" ]
    }

    # Group member can update the group information
    path "identity/group/id/{{identity.groups.names.${local.policies[count.index]}.id}}" {
      capabilities = [ "update", "read" ]
    }
  EOT
}

locals {
  devops      = var.enable_devops_policy ? ["devops"] : []
  development = var.enable_development_policy ? ["development"] : []

  policies = concat(local.devops, local.development)
}