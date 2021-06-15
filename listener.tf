resource "aws_alb_listener" "http" {
  count             = length(local.http_ports)
  load_balancer_arn = aws_alb.ingress.arn
  port              = element(local.http_ports, count.index)
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "400"
      message_body = "ALB does not know how to handle your request."
    }
  }
}

resource "aws_alb_listener" "https" {
  count             = length(local.https_ports)
  load_balancer_arn = aws_alb.ingress.arn
  port              = element(local.https_ports, count.index)
  protocol          = "HTTPS"
  certificate_arn   = local.alb_certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "400"
      message_body = "ALB does not know how to handle your request."
    }
  }
}