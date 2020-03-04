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

output "github_accessor" {
  value = var.enable_github ? vault_github_auth_backend.example[0].accessor : ""
}