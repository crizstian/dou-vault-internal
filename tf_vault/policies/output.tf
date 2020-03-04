output "list_of_policies" {
  value = {
    DevOps      = ["devops", vault_policy.user[0].name, ],
    Development = ["development", vault_policy.user[0].name]
  }
}