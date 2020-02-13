# Create IAM policy to allow Consul to reach S3 bucket and KMS key
data "aws_iam_policy_document" "consul_bucket" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.consul_setup.arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.consul_setup.arn
    ]
  }
}

resource "aws_iam_role_policy" "consul_bucket" {
  name   = "${var.project_tag}-consul-bucket"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.consul_bucket.json
}

data "aws_iam_policy_document" "bucketkms" {
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey"
    ]
    resources = [
      "${aws_kms_key.bucketkms.arn}"
    ]
  }
}

resource "aws_iam_role_policy" "bucketkms" {
  name   = "${var.project_tag}-bucketkms"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.bucketkms.json
}

# Create IAM policy to allow Consul backups to reach S3 bucket
data "aws_iam_policy_document" "consul_backups" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = ["${aws_s3_bucket.consul_backups[0].arn}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucketVersions",
      "s3:ListBucket"
    ]
    resources = [aws_s3_bucket.consul_backups[0].arn]
  }
}

resource "aws_iam_role_policy" "consul_backups" {
  name   = "${var.project_tag}-consul-backups"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.consul_backups.json
}

resource "aws_iam_instance_profile" "instance_profile" {
  name_prefix = "${var.project_tag}-instance_profile"
  role        = aws_iam_role.instance_role.name

  # aws_launch_configuration.launch_configuration in this module sets create_before_destroy to true, which means
  # everything it depends on, including this resource, must set it as well, or you'll get cyclic dependency errors
  # when you try to do a terraform destroy.
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_role" "instance_role" {
  name_prefix        = "${var.project_tag}-instance-role"
  assume_role_policy = data.aws_iam_policy_document.instance_role.json

  # aws_iam_instance_profile.instance_profile in this module sets create_before_destroy to true, which means
  # everything it depends on, including this resource, must set it as well, or you'll get cyclic dependency errors
  # when you try to do a terraform destroy.
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "SystemsManager" {
  role       = aws_iam_role.instance_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy" "auto_discover_cluster" {
  name   = "auto-discover-cluster"
  role   = aws_iam_role.instance_role.name
  policy = data.aws_iam_policy_document.auto_discover_cluster.json
}

data "aws_iam_policy_document" "auto_discover_cluster" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "autoscaling:DescribeAutoScalingGroups",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "vault-kms-unseal" {
  statement {
    sid       = "VaultKMSUnseal"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey",
    ]
  }
}

resource "aws_iam_role_policy" "kms_key" {
  name   = "${var.project_tag}-kms-key"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.vault-kms-unseal.json
}
