output "arn" {
  value = aws_alb.ingress.arn
}

output "domain_name" {
  value = aws_alb.ingress.dns_name
}