# vim:ts=2:sw=2:et:

locals {
  route53_records = var.dns_enabled ? var.crt_hostnames : []

  sg_id           = var.create_security_group ? aws_security_group.lb.*.id : []
  security_groups = compact(concat(var.security_groups, local.sg_id))

}

