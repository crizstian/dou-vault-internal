variable "enable_azure_dynamic_secret" {}
variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_resource_group" {}

resource "vault_azure_secret_backend" "azure" {
  count = var.enable_azure_dynamic_secret ? 1 : 0

  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}

resource "vault_azure_secret_backend_role" "devops" {
  count = var.enable_azure_dynamic_secret ? 1 : 0

  backend                     = vault_azure_secret_backend.azure.0.path
  role                        = "devops"
  ttl                         = 3600
  max_ttl                     = 7600

  # not working yet, we need to check azure roles permissions
  // azure_roles {
  //   role_name = "Contributor"
  //   scope =  "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_resource_group}"
  // }

  # not working yet, we need to check azure roles permissions
  application_object_id       = "3e611541-b009-4919-b544-c265509de345"
}