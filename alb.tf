resource "aws_alb" "ingress" {
  name            = "${var.name}"
  security_groups = ["${aws_security_group.lb.id}"]
  subnets         = ["${var.public_subnets}"]

  access_logs {
    bucket  = "${local.access_logs_bucket}"
    prefix  = "${local.access_logs_prefix}"
    enabled = "${local.access_logs_enable}"
  }

}