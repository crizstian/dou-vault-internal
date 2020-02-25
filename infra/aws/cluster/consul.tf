data "template_cloudinit_config" "consul" {
  depends_on = [
    aws_s3_bucket_object.object1,
    aws_s3_bucket_object.object2,
    aws_s3_bucket_object.object3,
  ]
  
  gzip          = true
  base64_encode = true
  part {
    filename     = "install-consul.sh"
    content_type = "text/x-shellscript"
    content = templatefile("${path.cwd}/cluster/consul-installation.tpl",
      {
        consul_scheme                       = "https",
        consul_port                         = 8500,
        consul_path                         = var.consul_path,
        consul_user                         = var.consul_user,
        ca_file_path                        = "/opt/vault/config/certs/ca.crt.pem",
        cert_file_path                      = "/opt/vault/config/certs/server.crt.pem",
        key_file_path                       = "/opt/vault/config/certs/server.key.pem",
        server                              = var.server,
        client                              = var.client,
        config_dir                          = var.config_dir,
        data_dir                            = var.data_dir,
        systemd_stdout                      = var.systemd_stdout,
        systemd_stderr                      = var.systemd_stderr,
        bin_dir                             = var.bin_dir,
        cluster_tag_key                     = var.cluster_tag_key,
        cluster_tag_value                   = "${var.project_tag}-${var.cluster_tag_value}",
        datacenter                          = var.datacenter,
        autopilot_cleanup_dead_servers      = var.autopilot_cleanup_dead_servers,
        autopilot_last_contact_threshold    = var.autopilot_last_contact_threshold,
        autopilot_max_trailing_logs         = var.autopilot_max_trailing_logs,
        autopilot_server_stabilization_time = var.autopilot_server_stabilization_time,
        autopilot_redundancy_zone_tag       = var.autopilot_redundancy_zone_tag,
        autopilot_disable_upgrade_migration = var.autopilot_disable_upgrade_migration,
        autopilot_upgrade_version_tag       = var.autopilot_upgrade_version_tag,
        enable_gossip_encryption            = var.enable_gossip_encryption,
        enable_rpc_encryption               = var.enable_rpc_encryption,
        environment                         = var.environment,
        recursor                            = var.recursor,
        bucket                              = aws_s3_bucket.consul_setup.id,
        bucketkms                           = aws_kms_key.bucketkms.id,
        enable_acls                         = var.enable_acls,
        enable_consul_http_encryption       = var.enable_consul_http_encryption,
        consul_backup_bucket                = aws_s3_bucket.consul_backups[0].id,
      }
    )
  }
}

module "consul" {
  source            = "terraform-aws-modules/autoscaling/aws"
  version           = "3.4.0"
  image_id          = var.ami_id
  name              = "${var.project_tag}-consul"
  health_check_type = "EC2"
  max_size          = var.consul_cluster_size
  min_size          = var.consul_cluster_size
  desired_capacity  = var.consul_cluster_size
  instance_type     = "t2.small"
  vpc_zone_identifier  = module.vpc.public_subnets
  key_name             = var.ssh_key_name
  enabled_metrics      = ["GroupTotalInstances"]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  target_group_arns    = [        
    aws_lb_target_group.tg_ncv_consul.arn
  ]
  
  tags = concat(
    [
      for k, v in var.tags :
      {
        key : k
        value : v
        propagate_at_launch : true
      }
    ],
    [
      {
        key                 = var.cluster_tag_key
        value               = "${var.project_tag}-${var.cluster_tag_value}"
        propagate_at_launch = true
      }
    ]
  )
  user_data = data.template_cloudinit_config.consul.rendered
}