resource "random_id" "project_tag" {
  byte_length = 4
}

# Creates Cluster self signed certificates with the following dns names enabled
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

# to access the cluster you need to do it through aws ssh manager or through the load balancer via the api
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


# We can enable Vault DR just by uncomment the following module and set another region with the provider attr.
// module "vault-consul-dr-cluster" {
//   source = "./cluster"

//   tls_files                  = module.tls-files.tls_files
//   consul_cluster_size        = 3
//   vault_cluster_size         = 3
//   enable_deletion_protection = false
//   subnet_second_octet        = "1"
//   force_bucket_destroy       = true
//   project_tag                = random_id.project_tag.hex
//   tags                       = var.tags
// }