# Install Vault
data "template_cloudinit_config" "vault" {
    depends_on = [
    aws_s3_bucket_object.object1,
    aws_s3_bucket_object.object2,
    aws_s3_bucket_object.object3,
    data.template_cloudinit_config.consul,
  ]
  
  gzip          = true
  base64_encode = true
  part {
    filename     = "install-vault.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.cwd}/cluster/vault-installation.tpl",
      {
      consul_scheme                 = "https",
      consul_port                   = 8500,
      consul_path                   = var.consul_path,
      vault_path                    = var.vault_path,
      consul_user                   = var.consul_user,
      vault_user                    = var.vault_user,
      ca_file_path                  = "/opt/vault/config/certs/ca.crt.pem",
      cert_file_path                = "/opt/vault/config/certs/server.crt.pem",
      key_file_path                 = "/opt/vault/config/certs/server.key.pem",
      server                        = var.server,
      client                        = var.client,
      config_dir                    = var.config_dir,
      data_dir                      = var.data_dir,
      systemd_stdout                = var.systemd_stdout,
      systemd_stderr                = var.systemd_stderr,
      bin_dir                       = var.bin_dir,
      cluster_tag_key               = var.cluster_tag_key,
      cluster_tag_value             = "${var.project_tag}-${var.cluster_tag_value}",
      datacenter                    = var.datacenter,
      enable_gossip_encryption      = var.enable_gossip_encryption,
      enable_rpc_encryption         = var.enable_rpc_encryption,
      environment                   = var.environment,
      recursor                      = var.recursor,
      bucket                        = aws_s3_bucket.consul_setup.id,
      bucketkms                     = aws_kms_key.bucketkms.id,
      enable_acls                   = var.enable_acls,
      enable_consul_http_encryption = var.enable_consul_http_encryption,
      consul_backup_bucket          = aws_s3_bucket.consul_backups[0].id,
      kms_key                       = aws_kms_key.vault.id
      }
    )
  }
}

module "vault" {
  source            = "terraform-aws-modules/autoscaling/aws"
  version           = "3.4.0"
  image_id          = var.ami_id
  name              = "${var.project_tag}-vault"
  health_check_type = "EC2"
  max_size          = var.vault_cluster_size
  min_size          = var.vault_cluster_size
  desired_capacity  = var.vault_cluster_size
  instance_type     = "t2.small"
  target_group_arns = [        
    aws_lb_target_group.tg_ncv_vault.arn,
  ]
  vpc_zone_identifier  = module.vpc.public_subnets
  key_name             = var.ssh_key_name
  enabled_metrics      = ["GroupTotalInstances"]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  user_data            = data.template_cloudinit_config.vault.rendered
  tags = [
    for k, v in var.tags :
    {
      key : k
      value : v
      propagate_at_launch : true
    }
  ]
}