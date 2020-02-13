data "aws_elb_service_account" "main" {}


resource "aws_lb" "cluster_nlb" {
  name                             = "${var.project_tag}-nlb"
  internal                         = var.nlb_internal
  load_balancer_type               = var.nlb_load_balancer_type
  enable_cross_zone_load_balancing = var.nlb_enable_cross_zone_load_balancing
  enable_deletion_protection       = var.nlb_enable_deletion_protection
  subnets                          = module.vpc.public_subnets
}

resource "aws_lb_target_group" "tg_ncv_vault" {
  name       = "${var.project_tag}-tg-ncv-vault"
  port       = 8200
  protocol   = "TCP"
  vpc_id     = module.vpc.vpc_id

  health_check {
    interval = "30"
    port     = "8200"
    protocol = "TCP"
    healthy_threshold   = "10"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_target_group" "tg_ncv_consul" {
  name       = "${var.project_tag}-tg-ncv-consul"
  port       = 8500
  protocol   = "TCP"
  vpc_id     = module.vpc.vpc_id

  health_check {
    interval            = "30"
    port                = "8500"
    protocol            = "TCP"
    healthy_threshold   = "10"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_listener" "lb_listener_8200" {
  load_balancer_arn = aws_lb.cluster_nlb.arn
  port              = "8200"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_ncv_vault.arn
  }
}

resource "aws_lb_listener" "lb_listener_8500" {
  load_balancer_arn = aws_lb.cluster_nlb.arn
  port              = "8500"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_ncv_consul.arn
  }
}