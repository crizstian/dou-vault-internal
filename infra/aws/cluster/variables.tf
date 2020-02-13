variable "nlb_internal" {
  default = false
}
variable "nlb_load_balancer_type" {
  default = "network"
}
variable "nlb_enable_cross_zone_load_balancing" {
  default = true
}
variable "nlb_enable_deletion_protection" {
  default = false
}

variable "tags" {
  default = {
    Project = "vault-internal-dou"
  }
}

variable "project_tag" {}

variable "prefix" { default = "" }
variable "ssh_key_name" { default = "" }
variable "consul_cluster_size" { default = 3 }
variable "vault_cluster_size" { default = 3 }
variable "ami_id" { default = "ami-0e8cdac6c77c4f327" }

variable "cluster_tag_key" { default = "consul-servers" }
variable "cluster_tag_value" { default = "auto-join" }
variable "consul_path" { default = "" }
variable "vault_path" { default = "" }
variable "consul_user" { default = "" }
variable "vault_user" { default = "" }
variable "ca_path" { default = "" }
variable "cert_file_path" { default = "" }
variable "key_file_path" { default = "" }
variable "server" { default = true }
variable "client" { default = false }
variable "config_dir" { default = "" }
variable "data_dir" { default = "" }
variable "systemd_stdout" { default = "" }
variable "systemd_stderr" { default = "" }
variable "bin_dir" { default = "" }
variable "datacenter" { default = "" }
variable "autopilot_cleanup_dead_servers" { default = "" }
variable "autopilot_last_contact_threshold" { default = "" }
variable "autopilot_max_trailing_logs" { default = "" }
variable "autopilot_server_stabilization_time" { default = "" }
variable "autopilot_redundancy_zone_tag" { default = "az" }
variable "autopilot_disable_upgrade_migration" { default = "" }
variable "autopilot_upgrade_version_tag" { default = "" }
variable "enable_gossip_encryption" { default = true }
variable "gossip_encryption_key" { default = "" }
variable "enable_rpc_encryption" { default = true }
variable "environment" { default = "" }
variable "recursor" { default = "" }
variable "enable_acls" { default = true }
variable "force_bucket_destroy" {
  description = "Boolean to force destruction of s3 buckets"
  default     = false
  type        = bool
}
variable "enable_consul_http_encryption" { default = true }
variable "enable_deletion_protection" { default = true }
variable "subnet_second_octet" { default = "0" }
variable "create_bastion" { default = true }

variable "tls_files" {}

variable "ca_public_key_file_path" {
  description = "Write the PEM-encoded CA certificate public key to this path (e.g. /etc/tls/ca.crt.pem)."
  default = "ca.crt.pem"
}

variable "public_key_file_path" {
  description = "Write the PEM-encoded certificate public key to this path (e.g. /etc/tls/vault.crt.pem)."
  default = "server.crt.pem"
}

variable "private_key_file_path" {
  description = "Write the PEM-encoded certificate private key to this path (e.g. /etc/tls/vault.key.pem)."
  default = "server.key.pem"
}