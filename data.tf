# vim:ts=2:sw=2:et:

data "aws_route53_zone" "z" {
  count = local.acm_enabled ? 1 : 0

  name = local.domain_zone
}

