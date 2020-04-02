variable "enable_provisioner_policy" {
  default = false
}

resource "vault_policy" "provisioner" {
  count = var.enable_provisioner_policy ? 1 : 0

  name   = "gitlab-ci"
  policy = <<EOT
    # Manage auth methods broadly across Vault
    path "auth/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    # Create, update, and delete auth methods
    path "sys/auth/*"
    {
      capabilities = ["create", "update", "delete", "sudo"]
    }
    # List auth methods
    path "sys/auth"
    {
      capabilities = ["read"]
    }
    # List existing policies
    path "sys/policies/acl"
    {
      capabilities = ["list"]
    }
    # Create and manage ACL policies
    path "sys/policies/acl/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    # List, create, update, and delete key/value secrets
    path "secret/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    # Manage secrets engines
    path "sys/mounts/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    # List existing secrets engines.
    path "sys/mounts"
    {
      capabilities = ["read"]
    }
    # Transit Keys
    path "transit/keys/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    # Group member can update the group information
    path "identity/*" {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    path "aws/*" {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    path "gcp/*" {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    path "azure/*" {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
  EOT
}