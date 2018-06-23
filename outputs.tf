output "arn" {
  description = "Loadbalancer arn."
  value       = "${aws_alb.ingress.arn}"
}
output "ports" {
  desription = "List of coma-separated ports (string)."
  value      = "${join(",",local.all_ports)}"
}