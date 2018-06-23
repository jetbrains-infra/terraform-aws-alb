resource "aws_lb_listener_rule" "default" {
  count = "${length(var.routs)}"
  action {
    target_group_arn = "${chomp(element(split("->", element(var.routs, count.index)), 1))}"
    type = "forward"
  }

  condition {
    field  = "host-header"
    values = ["${chomp(element(split("->", element(var.routs, count.index)), 0))}"]
  }

  listener_arn = "${lookup(
    local.listeners,
    element(split(":", chomp(element(split("->", element(var.routs, count.index)), 0))), 1)
  )}"
}
