# vim:ts=2:sw=2:et

resource "aws_acm_certificate" "crt" {
  count = local.acm_enabled ? 1 : 0

  domain_name               = var.crt_hostnames[0]
  subject_alternative_names = [ for h in var.crt_hostnames: h if h != var.crt_hostnames[0] ]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_route53_record" "crt-validation" {
  count = local.acm_enabled ? 1 : 0

  name = aws_acm_certificate.crt.0.domain_validation_options.0.resource_record_name
  type = aws_acm_certificate.crt.0.domain_validation_options.0.resource_record_type

  records = [
    aws_acm_certificate.crt.0.domain_validation_options.0.resource_record_value
  ]

  zone_id = var.zone_id 
  ttl     = 60
}

resource "aws_acm_certificate_validation" "crt-validation" {
  count = local.acm_enabled ? 1 : 0

  certificate_arn         = aws_acm_certificate.crt.0.arn
  validation_record_fqdns = [ aws_route53_record.crt-validation.0.fqdn ]
}

