resource "aws_security_group" "lb" {
  name = "LoadBalancer ${var.name}"
  vpc_id = "${local.vpc_id}"
}

resource "aws_security_group_rule" "lb_allow_outgoing_connection_to_private_subnets" {
  count                    = "${length(local.all_ports)}"
  from_port                = "${element(local.all_ports, count.index)}"
  protocol                 = "TCP"
  security_group_id = "${aws_security_group.lb.id}"
  to_port           = "${element(local.all_ports, count.index)}"
  type              = "egress"
  cidr_blocks       = ["${var.target_cidr_blocks}"]
}

resource "aws_security_group_rule" "lb_allow_incoming_connection_from_internet" {
  count             = "${length(local.all_ports)}"
  from_port         = "${element(local.all_ports, count.index)}"
  protocol          = "TCP"
  security_group_id = "${aws_security_group.lb.id}"
  to_port           = "${element(local.all_ports, count.index)}"
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}