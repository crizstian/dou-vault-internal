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
  project      = "gcp-vault-admin"
  token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  # to be done to set the appropiate bindings
  binding {
    resource = "//cloudresourcemanager.googleapis.com/projects/gcp-vault-admin"

    # to be done to set the appropiate roles
    roles = [
      "roles/billing.projectManager",
      "roles/cloudfunctions.developer",
      "roles/cloudkms.admin",
      "roles/cloudsql.admin",
      "roles/compute.admin",
      "roles/container.admin",
      "roles/container.clusterAdmin",
      "roles/datalabeling.admin",
      "roles/dns.reader",
      "roles/gkehub.admin",
      "roles/iam.roleViewer",
      "roles/networkmanagement.admin",
      "roles/orgpolicy.policyViewer",
      "roles/recommender.computeAdmin",
      "roles/recommender.firewallAdmin",
      "roles/run.admin",
      "roles/servicenetworking.networksAdmin",
      "roles/storage.admin",
    ]
  }
}