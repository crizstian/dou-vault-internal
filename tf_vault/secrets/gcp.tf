variable "enable_gcp_dynamic_secret" {}
variable "gcp_root_project" {}

resource "vault_gcp_secret_backend" "gcp" {
  count = var.enable_gcp_dynamic_secret ? 1 : 0
  
  path        = "gcp"
  credentials = file("./files/vault-gcp.json")
}

resource "vault_gcp_secret_roleset" "roleset" {
  count = var.enable_gcp_dynamic_secret ? 1 : 0
  
  backend      = vault_gcp_secret_backend.gcp.0.path
  roleset      = "devops"
  secret_type  = "access_token"
  project      = var.gcp_root_project
  token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  # to be done to set the appropiate bindings
  binding {
    resource = "//cloudresourcemanager.googleapis.com/projects/${var.gcp_root_project}"

    # to be done to set the appropiate roles
    roles = [
      "roles/viewer",
    ]
  }
}