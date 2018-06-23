resource "aws_alb_listener" "http" {
  count             = "${length(var.http_ports)}"
  load_balancer_arn = "${aws_alb.ingress.arn}"
  port              = "${element(var.http_ports, count.index)}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${var.default_target_group_arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "https" {
  count             = "${length(var.https_ports)}"
  load_balancer_arn = "${aws_alb.ingress.arn}"
  port              = "${element(var.https_ports, count.index)}"
  protocol          = "HTTPS"
  certificate_arn   = "${var.certificate_arn}"

  default_action {
    target_group_arn = "${var.default_target_group_arn}"
    type             = "forward"
  }
}