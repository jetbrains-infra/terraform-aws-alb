resource "aws_alb_listener" "http" {
  count             = "${length(local.http_ports)}"
  load_balancer_arn = "${aws_alb.ingress.arn}"
  port              = "${element(local.http_ports, count.index)}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.default_http.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "https" {
  count             = "${length(local.https_ports)}"
  load_balancer_arn = "${aws_alb.ingress.arn}"
  port              = "${element(local.https_ports, count.index)}"
  protocol          = "HTTPS"
  certificate_arn   = "${local.alb_certificate_arn}"

  default_action {
    target_group_arn = "${aws_alb_target_group.default_https.arn}"
    type             = "forward"
  }
}