# vim:ts=2:sw=2:et:

resource "aws_lb_target_group" "tgs" {
  count = length(var.target_groups)

  vpc_id   = var.vpc_id
  name     = lookup(var.target_groups[count.index], "name")
  port     = lookup(var.target_groups[count.index], "port")
  protocol = lookup(var.target_groups[count.index], "protocol")
  
  deregistration_delay = lookup(var.target_groups[count.index], "deregistration_delay")
  slow_start           = lookup(var.target_groups[count.index], "slow_start")
  
  health_check {
    enabled             = lookup(var.target_groups[count.index].health_check, "enabled",            true)
    path                = lookup(var.target_groups[count.index].health_check, "path",               "/")
    port                = lookup(var.target_groups[count.index].health_check, "port")
    protocol            = lookup(var.target_groups[count.index].health_check, "protocol",           "HTTP")
    interval            = lookup(var.target_groups[count.index].health_check, "interval",           10)
    timeout             = lookup(var.target_groups[count.index].health_check, "timeout",            5)
    healthy_threshold   = lookup(var.target_groups[count.index].health_check, "healthy_threshold",  3)
    unhealthy_threshold = lookup(var.target_groups[count.index].health_check, "unhealth_threshold", 2)
  }

  tags = var.tags
}

output "target-groups" {
  value = aws_lb_target_group.tgs
}

