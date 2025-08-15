variable "ipv4_primary_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC."
  type        = string
}

variable "ipv4_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  type = map(object({
    cidr_block           = string
    availability_zone_id = string
  }))
  default = {}
}

variable "name" {
  type = object({
    environment = string
    service     = string
    identifier  = string
  })
  description = "environment, service and identifier. part of naming standards"
}

variable "private_subnets" {
  type = map(map(object({
    cidr_block           = string
    availability_zone_id = string
  })))
  default = null
}

variable "intra_subnets" {
  type = map(map(object({
    cidr_block           = string
    availability_zone_id = string
    hscn_connectivity    = string
  })))
  default = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "tgw_id_backbone" {
  type        = string
  description = "TGW Backbone ID"
}

variable "tgw_id_hscn" {
  type        = string
  description = "TGW HSCN ID"
}

variable "route53_resolver_rules" {
  type = map(object({
    rule_id = string
  }))
  description = "Route53 resolver rules to attach to VPC"
}

variable "peer_owner_id" {
  type = string
}

variable "peer_region" {
  type = string
}

variable "peer_vpc_id" {
  type = string
}

variable "flow_log_cloudwatch_log_group_retention_in_days" {
  type = number
  default = 14
  description = "Specifies the number of days you want to retain log events in the specified log group for VPC flow logs."
}

variable "standard_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - standard."
  default     = {}
}

variable "standard_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - standard."
  default     = {}
}

variable "standard_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - standard."
  default     = {}
}

variable "db_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - db."
  default     = {}
}

variable "db_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - db."
  default     = {}
}

variable "db_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - db."
  default     = {}
}

variable "private_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - private."
  default     = {}
  
}

variable "backup_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - backup."
  default     = {}
}

variable "backup_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - backup."
  default     = {}
}

variable "backup_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - backup."
  default     = {}
}

variable "app_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - app."
  default     = {}
}

variable "app_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - app."
  default     = {}
}

variable "app_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - app."
  default     = {}
}

variable "firecracker_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - firecracker."
  default     = {}
}

variable "firecracker_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - firecracker."
  default     = {}
}

variable "firecracker_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - firecracker."
  default     = {}
}

variable "legacy_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - legacy."
  default     = {}
}

variable "legacy_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - legacy."
  default     = {}
}

variable "legacy_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - legacy."
  default     = {}
}

variable "onprem_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - onprem."
  default     = {}
}

variable "onprem_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - onprem."
  default     = {}
}

variable "private_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - private."
  default     = {}

}

variable "onprem_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - onprem."
  default     = {}
}

variable "awspatchstore_sg_rules_cidr_block" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - aws patchstores."
  default     = {}
}

variable "sds_sg_rules_cidr_block" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - sds."
  default     = {}
}

variable "private_sg_rules_cidr_block" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - private."
  default     = {}
}

variable "oapi_sg_rules_cidr_block" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - oapi."
  default     = {}
}

variable "legacy_sds_sg_rules_cidr_block" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - legacy sds."
  default     = {}
}

variable "exa_sg_rules_cidr_blocks" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    cidr     = list(string)
  }))
  description = "Security group rules to CIDR blocks - exa."
  default     = {}
}

variable "exa_sg_rules_self" {
  type = map(object({
    desc     = string
    type     = string
    from     = number
    to       = number
    protocol = string
    self     = bool
  }))
  description = "Security group rules to self reference - exa."
  default     = {}
}

variable "exa_sg_rules_security_group" {
  type = map(object({
    desc      = string
    type      = string
    from      = number
    to        = number
    protocol  = string
    source_sg = string
  }))
  description = "Security group rules to another sg - exa."
  default     = {}
}
