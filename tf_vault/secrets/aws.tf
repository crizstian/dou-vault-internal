variable "enable_aws_dynamic_secret" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "aws_roles" {}

resource "vault_aws_secret_backend" "aws" {
  count = var.enable_aws_dynamic_secret ? 1 : 0
  
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

resource "vault_aws_secret_backend_role" "role" {
  count = var.enable_aws_dynamic_secret ? length(var.aws_roles) : 0 
  
  backend = vault_aws_secret_backend.aws[0].path
  name    = var.aws_roles[count.index].name
  credential_type = "iam_user"
  policy_document = file(var.aws_roles[count.index].role)
}

