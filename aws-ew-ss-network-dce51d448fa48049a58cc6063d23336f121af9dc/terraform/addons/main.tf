resource "aws_route53_resolver_rule_association" "this" {
  for_each         = var.route53_resolver_rules
  resolver_rule_id = each.value.rule_id
  vpc_id           = data.aws_vpc.this.id
}

data "aws_route_tables" "this" {
  vpc_id = data.aws_vpc.this.id
}

data "aws_route_tables" "igw_filter" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

data "aws_route_tables" "internal_supp_services" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["*internal*"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-supp-services"]
  }
}


data "aws_route_tables" "internal_app" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-ss-apps"]
  }
}

data "aws_route_tables" "hscn_nlb" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-nlb-hscn"]
  }
}

data "aws_route_tables" "internal_other" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-managed-ad*", "${var.name.environment}-${var.name.service}-net-rt-tgw-vpce*"]
  }
}

data "aws_route_tables" "internal_other_tgw_only" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-hda*", "${var.name.environment}-${var.name.service}-net-rt-certauth*","${var.name.environment}-${var.name.service}-net-rt-rootca*"]
  }
}

data "aws_route_tables" "fsx" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-fsx*"]
  }
}

data "aws_route_tables" "internal_wsus" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-wsus"]
  }
}

data "aws_route_tables" "internal_db" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["internal"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-sql*"]
  }
}

data "aws_route_tables" "private" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-private*"]
  }
}


data "aws_route_tables" "private_2a" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-private*2a"]
  }
}

data "aws_route_tables" "private_2b" {
  vpc_id = data.aws_vpc.this.id
  filter {
    name   = "tag:Tier"
    values = ["private"]
  }
  filter {
    name   = "tag:Name"
    values = ["${var.name.environment}-${var.name.service}-net-rt-private*2b"]
  }
}

resource "aws_route" "tgw_app_routes" {
  for_each = local.app_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_private_routes" {
  for_each = local.private_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_db_routes" {
  for_each = local.db_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_nlb_routes" {
  for_each = local.nlb_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_other" {
  for_each = local.other_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_only_other" {
  for_each = local.other_tgw_only_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_fsx" {
  for_each = local.fsx_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "wsus_routes" {
  for_each = local.wsus_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}

resource "aws_route" "tgw_supp_services" {
  for_each = local.supp_services_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.cidr
  transit_gateway_id     = each.value.tgw_id
}


data "aws_vpc" "this" {
  cidr_block = var.ipv4_primary_cidr_block
}

locals {
  rt_id_list = compact(tolist(distinct(flatten([for x in tolist(data.aws_route_tables.igw_filter.ids) :
  [for y in tolist(data.aws_route_tables.this.ids) : x != y ? y : ""]]))))
}

resource "aws_route" "vpc_peering_route" {
  for_each = local.peering_routes_combined

  route_table_id            = each.value.rtb_id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = each.value.peering_id
}
resource "aws_route" "private_vpc_peering_route" {
  for_each = local.private_subnets_peering_routes_combined

  route_table_id            = each.value.rtb_id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = each.value.peering_id
}

resource "aws_route" "wsus_vpc_peering_route" {
  for_each = local.wsus_peering_routes_combined

  route_table_id            = each.value.rtb_id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = each.value.peering_id
}

resource "aws_route" "fsx_vpc_peering_route" {
  for_each = local.fsx_peering_routes_combined

  route_table_id            = each.value.rtb_id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = each.value.peering_id
}

resource "aws_route" "peering_route_ss_bastions" {
  count                     = length(data.aws_route_tables.this.ids)
  route_table_id            = data.aws_route_tables.this.ids[count.index]
  destination_cidr_block    = var.peering_route_cidr_block_ss_bastions
  vpc_peering_connection_id = var.bastions_peer_id
}

resource "aws_route" "peering_route_ss_sec_bastions" {
  count                     = length(data.aws_route_tables.this.ids)
  route_table_id            = data.aws_route_tables.this.ids[count.index]
  destination_cidr_block    = var.peering_route_sec_cidr_block_ss_bastion
  vpc_peering_connection_id = var.bastions_peer_id
}

resource "aws_route" "vgw_route" {
  for_each = local.vgw_routes_combined

  route_table_id         = each.value.rtb_id
  destination_cidr_block = each.value.vpc_cidr
  gateway_id             = each.value.gateway_id
}
