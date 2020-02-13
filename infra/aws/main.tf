provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region1
}

resource "random_id" "project_tag" {
  byte_length = 4
}

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

// module "bastion" {
//   source = "./bastion"

//   project_tag = random_id.project_tag.hex
//   tags        = var.tags
// }

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