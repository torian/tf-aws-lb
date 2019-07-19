# vim:ts=2:sw=2:et:

locals {
  acm_enabled     = var.acm_enabled && var.crt_hostnames != "" ? true : false
  route53_records = var.dns_enabled ? var.crt_hostnames : []

  sg_id           = var.create_security_group ? aws_security_group.lb.*.id : []
  security_groups = compact(concat(var.security_groups, local.sg_id))

  certificate_arn = local.acm_enabled ? aws_acm_certificate.crt.0.arn : var.certificate_arn != "" ? var.certificate_arn : null
}

