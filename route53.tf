# vim:ts=2:sw=2:et:

resource "aws_route53_record" "lb" {
  count = length(local.route53_records)

  zone_id = var.zone_id
  name    = local.route53_records[count.index]
  type    = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }

  weighted_routing_policy {
    weight = 255
  }

  set_identifier = "primary"
}

