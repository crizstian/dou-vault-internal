# resource "vault_ldap_auth_backend" "ldap" {
#     path        = "ldap"
#     url         = "ldaps://dc-01.example.org"
#     userdn      = "OU=Users,OU=Accounts,DC=example,DC=org"
#     userattr    = "sAMAccountName"
#     upndomain   = "EXAMPLE.ORG"
#     discoverdn  = false
#     groupdn     = "OU=Groups,DC=example,DC=org"
#     groupfilter = "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))"
# }

# resource "vault_ldap_auth_backend_user" "user" {
#     username = "test-user"
#     policies = ["admin", "default"]
#     backend  = vault_ldap_auth_backend.ldap.path
# }

/*resource "vault_ldap_auth_backend_group" "group" {
    groupname = "dba"
    policies  = ["dba"]
    backend   = "${vault_ldap_auth_backend.ldap.path}"
}*/