## HOW TO RUN INFRA

The following information will need to be provided:

    - AWS ACCESS KEY: var.access_key
    - AWS SECRET KEY: var.secret_key
    - AWS REGION: var.region1

After provided those values(we reccomnd to use TF_VAR option) do terraform init and then terraform apply to deploy vault in AWS. This will deploy 3 vault clusters and 3 consul clusters. If you would like to change that you can change consul_cluster_size and vault_cluster_size to the value you desire.

*** Note: After deploying vault it is necasarry to configure manually route53 on AWS so that the loadbalancer points to the correct DNS.

### TLS module

We have created a TLS module where you can especify a list of the DNS you would like to add to the certificate.

                module "tls-files" {
                source = "./tls"

                dns_names = [
                    "vault.service.consul",
                    "server.dc1.consul",
                    "server.dc2.consul",
                    "server.dc1-region.nomad",
                    "server.dc2-region.nomad",
                    "douvault.com",
                    "vault.douvault.com",
                    "*.douvault.com",
                    "*",
                ]
                }

As you can see you can easily add the DNS requiered for the certificate.

### Cluster

A cluster module was created to be able to deploy vault/consul cluster and modify certain parameters depending on the requirements.

                module "vault-consul-primary-cluster" {
                source = "./cluster"

                tls_files                  = module.tls-files.tls_files
                consul_cluster_size        = 3
                vault_cluster_size         = 3
                enable_deletion_protection = false
                subnet_second_octet        = "0"
                force_bucket_destroy       = true
                project_tag                = random_id.project_tag.hex
                tags                       = var.tags
                }

As you can see, you can easily call this module and change the size of the cluster. You can also select tls certificates you would like to add to your clusters.
