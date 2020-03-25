## HOW TO RUN TF_VAULT

TF_VAULT implements the `vault-terraform-provider` to configure the DOU Vault Service. 

### Contributors
- Cristian Ramirez <cristian.ramirez@digitalonus.com>
- Bernardo Garza <bernardo.garza@digitalonus.com>
- Marin Salinas <marin.salinas@digitalonus.com>

### Services available in Vault

- AWS Dynamic Secrets
  - attaches a devops iam role and generates the dynamic keys
- GCP Dynamic Secrets
- Azure Dynamic Secrets
- KV secret engine with a personal path scoped to each user
- Transit Secret Engine for Encryption as a Service
  - 3 keys generated for each team
    - devops
    - development
    - admin
- multi authentication processes which uses identity entity and identity groups to assign the proper policies no matter what authentication process you use.
  - github
  - userpass // for testing purposes
  - ldap // coming next


### How to add a user to DOU Vault




### Required env variables

- CONSUL_HTTP_TOKEN
- CONSUL_CLIENT_CERT

- VAULT_CACERT
- VAULT_TOKEN

---
For Adding Modules or initializing 
```
CONSUL_HTTP_TOKEN=... CONSUL_CLIENT_CERT="./files/ca.crt.key"  terraform init
```

---
For running a Terraform Plan / Apply
```
CONSUL_HTTP_TOKEN=... CONSUL_CLIENT_CERT="./files/ca.crt.key" VAULT_CACERT="./files/ca.crt.key" VAULT_TOKEN=... terraform plan / apply
```


