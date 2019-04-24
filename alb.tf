resource "aws_alb" "ingress" {
  name            = "${local.name}"
  security_groups = ["${aws_security_group.alb.id}"]
  subnets         = ["${local.public_subnets}"]

  access_logs {
    bucket  = "${local.access_logs_bucket}"
    prefix  = "${local.access_logs_prefix}"
    enabled = "${local.access_logs_enable}"
  }

  tags {
    Service = "${local.name}"
    Stack   = "${local.stack}"
  }
}