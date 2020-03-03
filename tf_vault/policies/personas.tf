variable "enable_admin_policy" {
  default = false
}
variable "enable_provisioner_policy" {
  default = false
}

# Personas Policies
resource "vault_policy" "admin-policy" {
  count = var.enable_admin_policy ? 1 : 0

  name   = "admin"
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
    # Read health checks
    path "sys/health"
    {
      capabilities = ["read", "sudo"]
    }
  EOT
}


# Personas Policies
resource "vault_policy" "provisioner-policy" {
  count = var.enable_provisioner_policy ? 1 : 0

  name   = "provisioner"
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
    # List auth methods
    path "sys/mounts"
    {
      capabilities = ["read"]
    }
    # List existing policies
    path "sys/policies/acl"
    {
      capabilities = ["list"]
    }
    # Create and manage ACL policies via API & UI
    path "sys/policies/acl/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    path "consul/*"
    {
      capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    }
    # List, create, update, and delete key/value secrets
    path "secret/*"
    {
      capabilities = ["create", "read", "update", "delete", "list"]
    }
  EOT
}
