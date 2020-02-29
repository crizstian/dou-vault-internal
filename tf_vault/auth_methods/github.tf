variable "enable_github" {
  default = false
}
variable "github_token_policies" {
  default = []
}

resource "vault_github_auth_backend" "example" {
  count = var.enable_github ? 1 : 0
  
  organization   = "DigitalOnUs"
  token_policies = var.github_token_policies
}