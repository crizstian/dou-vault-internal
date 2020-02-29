resource "vault_policy" "admin" {
  name = "admin"

  policy = <<EOT
    path "aws2/*" {
      capabilities = ["create", "read", "delete", "update", "list"]
    }
  EOT
}