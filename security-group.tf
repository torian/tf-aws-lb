# vim:ts=2:sw=2:et:

resource "aws_security_group" "lb" {
  count = length(var.security_groups) > 0 ? 0 : 1

  name        = "${var.lb_name}-sg"
  description = "${var.lb_name}-sg"
  vpc_id      = var.vpc_id
  tags        = merge(
    var.tags, 
    map("Name", "${var.lb_name}-sg")
  )

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  dynamic "ingress" {
    iterator = r
    for_each = [ for i in var.security_group_rules: {
      from_port       = i.from_port
      to_port         = i.to_port
      protocol        = i.protocol
      self            = i.self
      cidr_blocks     = i.cidr_blocks
      security_groups = i.security_groups
      description     = i.description
    }]
  
    content {
      from_port       = r.value.from_port
      to_port         = r.value.to_port
      protocol        = r.value.protocol
      self            = r.value.self
      cidr_blocks     = r.value.cidr_blocks
      security_groups = r.value.security_groups
      description     = r.value.description
    }
  }
}

output "security-group" {
  value = aws_security_group.lb.0
}

