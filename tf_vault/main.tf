provider "vault" {
  address = "https://vault.douvault.com"
  token   = var.vault_token
  skip_tls_verify = true
}
