# vim:ts=2:sw=2:et:

variable "vpc_id" {
  description = "VPC ID. Required for target groups & security groups"
  default     = ""
}

variable "lb_name" {}

variable "lb_internal" {
  description = "Toggle to make load balancer is internal (true) / public (false)"
  type        = bool
  default     = true
}

variable "lb_type" {
  description = "Load balancer type"
  default     = "application"
}

variable "lb_subnets" {
  description = "List of subnets IDs"
  type        = list
  default     = []
}

variable "create_security_group" {
  type    = bool
  default = true
}

variable "security_groups" {
  type    = list(string)
  default = []
}

variable "security_group_rules" {
  type = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    self            = bool
    security_groups = list(string)
    cidr_blocks     = list(string)
    description     = string
  }))
  default = [
    {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      self            = false
      cidr_blocks     = [ "0.0.0.0/0" ]
      security_groups = []
      description     = "HTTPS"
    },
  ]
}

variable "lb_idle_timeout" {
  default = 120
}

variable "lb_enable_deletion_protection" {
  description = "Enable deletion protection on LB"
  type        = bool
  default     = true
}

variable "lb_enable_cross_zone_load_balancing" {
  type    = bool
  default = true
}

variable "lb_enable_http2" {
  type    = bool
  default = true
}

variable "target_groups" {
  type = list(object({
    name = string
    port = number
    protocol = string
    deregistration_delay = number
    slow_start           = number
    health_check         = object({
      enabled             = bool
      path                = string
      port                = number
      protocol            = string
      interval            = number
      timeout             = number
      healthy_threshold   = number
      unhealthy_threshold = number
      matcher             = string
    })
  }))
  default = []
}

variable "listeners" {
  type = list(object({
    port               = number
    protocol           = string
    ssl_policy         = string
    target_group_index = number
    #action_block = object({
    #  type         = string
    #  target_group = number
    #})
    #
    #redirect_block = object({
    #  
    #})
  }))
  default = []
}

variable "acm_enabled" {
  type    = bool
  default = false
}

variable "dns_enabled" {
  type    = bool
  default = true
}

variable "zone_id" {
  default = ""
}

variable "crt_hostnames" {
  type    = list
  default = []
}

variable "tags" {
  type    = map
  default = {}
}

