resource "aws_security_group" "alb" {
  name   = "LoadBalancer ${local.name}"
  vpc_id = local.vpc_id
  tags   = local.tags
}

resource "aws_security_group_rule" "lb_allow_outgoing_connection_to_private_subnets" {
  protocol          = "-1"
  from_port         = "0"
  to_port           = "0"
  security_group_id = aws_security_group.alb.id
  type              = "egress"
  cidr_blocks       = local.target_cidr_blocks
}

resource "aws_security_group_rule" "lb_allow_incoming_connection_from_internet" {
  count             = length(local.all_ports)
  protocol          = "TCP"
  from_port         = element(local.all_ports, count.index)
  to_port           = element(local.all_ports, count.index)
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  cidr_blocks       = local.internal ? local.target_cidr_blocks : ["0.0.0.0/0"]
}