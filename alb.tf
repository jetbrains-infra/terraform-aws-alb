resource "aws_alb" "ingress" {
  name            = "${var.name}"
  security_groups = ["${aws_security_group.lb.id}"]
  subnets         = ["${var.public_subnets}"]
}