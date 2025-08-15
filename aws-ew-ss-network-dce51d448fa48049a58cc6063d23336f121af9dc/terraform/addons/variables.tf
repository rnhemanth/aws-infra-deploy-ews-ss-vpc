variable "tgw_id_backbone" {
  type        = string
  description = "TGW Backbone ID"
}

variable "ipv4_primary_cidr_block" {
  description = "(Optional) The IPv4 CIDR block for the VPC."
  type        = string
}

variable "route53_resolver_rules" {
  type = map(object({
    rule_id = string
  }))
  description = "Route53 resolver rules to attach to VPC"
}

variable "peering_route_cidr_block" {
  type = string
  description = "Peering route cidr block"
}

variable "england_peer_id" {
  type = string
  description = "England peer ID"
}

variable "peering_route_cidr_block_ss_bastions" {
  type = string
  description = "Peering route cidr block"
}

variable "peering_route_sec_cidr_block_ss_bastion" {
  type = string
  description = "Peering route secondary cidr block"
  
}

variable "bastions_peer_id" {
  type = string
  description = "Bastion VPC peer ID"
}

variable "tgw_app_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "tgw_db_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "tgw_nlb_hscn_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "wsus_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "tgw_other_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "tgw_fsx_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "tgw_wsus_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "vgw_routes" {
  type = map(object({
    vpc_cidr   = string
    gateway_id = string
  }))
  default = {}
}

variable "peering_routes" {
  type = map(object({
    vpc_cidr   = string
    peering_id = string
  }))
  default = {}
}
variable "private_subnets_peering_routes" {
  type = map(object({
    vpc_cidr   = string
    peering_id = string
  }))
  default = {}
}

variable "wsus_peering_routes" {
  type = map(object({
    vpc_cidr   = string
    peering_id = string
  }))
  default = {}
}

variable "fsx_peering_routes" {
  type = map(object({
    vpc_cidr   = string
    peering_id = string
  }))
  default = {}
}

variable "tgw_supp_services_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}

variable "tgw_private_routes" {
  type = map(object({
    cidr   = string
    tgw_id = string
  }))
  default = {}
}