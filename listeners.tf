# vim:ts=2:sw=2:et:

resource "aws_lb_listener" "listeners" {
  count = length(var.listeners)

  load_balancer_arn = aws_lb.lb.arn
  
  port            = var.listeners[count.index]["port"]
  protocol        = var.listeners[count.index]["protocol"]
  ssl_policy      = var.listeners[count.index]["ssl_policy"]

  certificate_arn = var.listeners[count.index]["protocol"] == "HTTPS" ? var.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = element(aws_lb_target_group.tgs.*.arn, var.listeners[count.index]["target_group_index"])
  }
}

output "listeners" {
  value = aws_lb_listener.listeners
}

