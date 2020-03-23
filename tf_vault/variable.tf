variable "vault_address" {
  default = "https://vault.douvault.com:8200"
}
variable "skip_tls_verify" {
  default = false
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "azure_subscription_id" {}
variable "azure_tenant_id" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_resource_group" {
  default = "bernie-christian-tests"
}