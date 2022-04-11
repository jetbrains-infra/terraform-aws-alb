resource "aws_alb" "ingress" {
  name            = local.alb_name
  internal        = local.internal
  security_groups = [aws_security_group.alb.id]
  subnets         = local.public_subnets

  dynamic "access_logs" {
    for_each = local.access_logs_enable ? [""] : []
    content {
      bucket  = local.access_logs_bucket
      prefix  = local.access_logs_prefix
      enabled = local.access_logs_enable
    }
  }

  tags = local.tags
}