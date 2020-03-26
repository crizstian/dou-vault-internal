locals {
  devops_members      = [for key, user in vault_identity_entity.entity :  user.id if user.metadata.team=="devops"]
  development_members = [for key, user in vault_identity_entity.entity :  user.id if user.metadata.team=="development"]
  admins_members      = [for key, user in vault_identity_entity.entity :  user.id if user.metadata.is_admin=="true"]

  devops_members_name      = sort([for key, user in vault_identity_entity.entity :  user.name if user.metadata.team=="devops"])
  development_members_name = sort([for key, user in vault_identity_entity.entity :  user.name if user.metadata.team=="development"])
  admins_members_name      = sort([for key, user in vault_identity_entity.entity :  user.name if user.metadata.is_admin=="true"])
}

output "devops" {
  value = local.devops_members
}

output "development" {
  value = local.development_members
}

output "admins" {
  value = local.admins_members
}

output "devops_name" {
  value = local.devops_members_name
}

output "development_name" {
  value = local.development_members_name
}

output "admins_name" {
  value = local.admins_members_name
}