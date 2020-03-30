## DigitalOnUs Vault Infrastructure

### **DOU Vault purpose**

### **DOU-VAULT-INTERNAL Repo Structure**

```
├── Readme.md
├── infra
│   ├── README.md
│   └── aws
│       ├── bastion
│       │   ├── main.tf
│       │   ├── network.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── bastion.tf
│       ├── cluster
│       │   ├── consul-installation.tpl
│       │   ├── consul.tf
│       │   ├── iam.tf
│       │   ├── network.tf
│       │   ├── nlb.tf
│       │   ├── output.tf
│       │   ├── s3-kms.tf
│       │   ├── variables.tf
│       │   ├── vault-installation.tpl
│       │   └── vault.tf
│       ├── main.tf
│       ├── provider.tf
│       ├── terraform.tfstate
│       ├── terraform.tfstate.backup
│       ├── terraform.tfvars
│       ├── tls
│       │   ├── ca.crt.pem
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   ├── server.crt.pem
│       │   ├── server.key.pem
│       │   └── variables.tf
│       └── variables.tf
└── tf_vault
    ├── README.md
    ├── auth_methods
    │   ├── aws.tf
    │   ├── azure.tf
    │   ├── gcp.tf
    │   ├── github.tf
    │   ├── ldap.tf
    │   └── user.tf
    ├── entities
    │   ├── github_entity.tf
    │   ├── output.tf
    │   └── userpass_entity.tf
    ├── files
    │   ├── aws
    │   │   └── devops.json
    │   ├── ca.crt.pem
    │   └── vault-gcp.json
    ├── generic_endpoints
    │   └── user.tf
    ├── groups
    │   ├── admins.tf
    │   ├── development.tf
    │   ├── devops.tf
    │   └── variables.tf
    ├── main.tf
    ├── policies
    │   ├── admin.tf
    │   ├── github.tf
    │   ├── group.tf
    │   ├── output.tf
    │   └── user.tf
    ├── provider.tf
    ├── secrets
    │   ├── aws.tf
    │   ├── azure.tf
    │   ├── gcp.tf
    │   ├── kv.tf
    │   └── transit.tf
    ├── users.tf
    ├── variable.tf
    └── workflow.jpg
```


### # **infra/**

Contains all the terraform configuration to deploy a 3 vault cluster with a 3 consul cluster for more documentation go to the `infra/aws/` folder.

### # **tf_vault/**

Contains all the vault configurations to enables the vault features, for more documentation go to the `tf_vault` folder.

All the project is configured following the `infrastructure as code` pattern.