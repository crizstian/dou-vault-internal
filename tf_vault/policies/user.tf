variable "enable_entity_policy" {
  default = false
}

resource "vault_policy" "user" {
  count = var.enable_entity_policy ? 1 : 0

  name   = "user"
  policy = <<EOT
    # Grant permissions on user specific path
    path "secret/{{identity.entity.name}}/*" {
        capabilities = [ "create", "update", "read", "delete", "list" ]
    }

    # The following policy creates a section of the KVv2 Secret Engine to a specific user
    path "secret/data/{{identity.entity.id}}/*" {
      capabilities = ["create", "update", "read", "delete"]
    }

    path "secret/metadata/{{identity.entity.id}}/*" {
      capabilities = ["list"]
    }

    # To list the available secrets engines
    path "sys/mounts" {
      capabilities = [ "read" ]
    }

    path "auth/token/*"
    {
      capabilities = ["read", "update"]
    }

    # Read token for verification & test
    path "auth/token/*" {
      capabilities = [ "read" ]
    }

    # Create tokens for AWS
    path "aws/creds/*" {
      capabilities = [ "read" ]
    }
    
    # Create tokens for AZURE
    path "azure/creds/*" {
      capabilities = [ "read" ]
    }

    # Create tokens for GCP
    path "gcp/token/*" {
      capabilities = [ "read" ]
    }
  EOT
}