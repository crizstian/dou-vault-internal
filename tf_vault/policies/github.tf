resource "vault_policy" "github" {
  count = var.enable_entity_policy ? 1 : 0

  name   = "github"
  policy = <<EOT
    path "auth/token/lookup-self" {
      capabilities = [ "read" ]
    }
  EOT
}