output "list_of_policies" {
  value = {
    DevOps      = [vault_policy.user[0].name, "devops"],
    Development = [vault_policy.user[0].name, "development"]
  }
}