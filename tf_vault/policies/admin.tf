resource "vault_policy" "admin" {
  name = "admin"

  policy = <<EOT
    path "aws2/*" {
      capabilities = ["create", "read", "delete", "update", "list"]
    }
  EOT
}

resource "vault_token" "admin" {
  policies  = ["admin", "default"]
  renewable = true
  ttl       = "24h"

  renew_min_lease = 43200
  renew_increment = 86400
}