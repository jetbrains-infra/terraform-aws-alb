resource "aws_alb_target_group" "default_http" {
  port = 80
  protocol = "HTTP"
  vpc_id = "${local.vpc_id}"
}

resource "aws_alb_target_group" "default_https" {
  port = 443
  protocol = "HTTPS"
  vpc_id = "${local.vpc_id}"
}