resource "vault_aws_secret_backend_role" "role" {
  count = length(var.aws_roles)

  backend         = vault_aws_secret_backend.aws.path
  name            = var.aws_roles[count.index].name
  credential_type = var.aws_roles[count.index].credential_type
  policy_document = var.aws_roles[count.index].policy_document
}