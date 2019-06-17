# vim:ts=2:sw=2:et:

resource "aws_lb" "lb" {
  name               = var.lb_name
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  subnets            = var.lb_subnets
  security_groups    = local.security_groups
  idle_timeout       = var.lb_idle_timeout
  
  enable_deletion_protection       = var.lb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.lb_enable_cross_zone_load_balancing
  enable_http2                     = var.lb_enable_http2

  ip_address_type = "ipv4"

  tags = var.tags
}

output "lb" {
  value = aws_lb.lb
}

