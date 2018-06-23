output "arn" {
  description = "Loadbalancer arn."
  value       = "${aws_alb.ingress.arn}"
}
output "ports" {
  description = "List of coma-separated ports (string)."
  value      = "${join(",",local.all_ports)}"
}