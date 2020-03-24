output "list_of_policies" {
  value = {
    admin       = local.admin
    devops      = local.devops
    development = local.development
    user        = local.user
  }
}