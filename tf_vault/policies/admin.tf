resource "vault_policy" "admin" {
  name = "admin-unused"

  policy = <<EOT
    path "aws2/*" {
      capabilities = ["create", "read", "delete", "update", "list"]
    }
  EOT
}