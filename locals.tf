# vim:ts=2:sw=2:et:

locals {
  acm_enabled     = var.acm_enabled && var.crt_hostnames != "" ? true : false
  route53_records = var.dns_enabled ? var.crt_hostnames : []

  security_groups = length(var.security_groups) > 0 ? var.security_groups : aws_security_group.lb.*.id

  certificate_arn = local.acm_enabled ? aws_acm_certificate.crt.0.arn : null

  domain_host = local.acm_enabled ? element(split(".", local.route53_records[0]), 0) : ""
  domain_zone = local.acm_enabled ? join(".", [ for d in split(".", local.route53_records[0]): d if d != local.domain_host]) : ""
}

