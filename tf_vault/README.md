HOW TO RUN TF_VAULT

Required env variables

- CONSUL_HTTP_TOKEN
- CONSUL_CLIENT_CERT

- VAULT_CACERT
- VAULT_TOKEN

For Adding Modules or initializing 
```
CONSUL_HTTP_TOKEN=... CONSUL_CLIENT_CERT="./files/ca.crt.key"  terraform init
```

For running a Terraform Plan / Apply
```
CONSUL_HTTP_TOKEN=... CONSUL_CLIENT_CERT="./files/ca.crt.key" VAULT_CACERT="./files/ca.crt.key" VAULT_TOKEN=... terraform plan / apply
```


