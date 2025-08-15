locals {
    route_tables_app = tomap({
    for rtb_id in data.aws_route_tables.internal_app.ids :
    rtb_id => ""
  })
  app_routes_combined = merge([
    for rtb_id, _ in local.route_tables_app :
    {
      for route_name, route_values in var.tgw_app_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

route_tables_db = tomap({
    for rtb_id in data.aws_route_tables.internal_db.ids :
    rtb_id => ""
  })
  db_routes_combined = merge([
    for rtb_id, _ in local.route_tables_db :
    {
      for route_name, route_values in var.tgw_db_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

route_tables_supp_services = tomap({
    for rtb_id in data.aws_route_tables.internal_supp_services.ids :
    rtb_id => ""
  })
  supp_services_routes_combined = merge([
    for rtb_id, _ in local.route_tables_supp_services :
    {
      for route_name, route_values in var.tgw_supp_services_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

 route_tables_nlb_hscn = tomap({
    for rtb_id in data.aws_route_tables.hscn_nlb.ids :
    rtb_id => ""
  })
  nlb_routes_combined = merge([
    for rtb_id, _ in local.route_tables_nlb_hscn :
    {
      for route_name, route_values in var.tgw_nlb_hscn_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

route_tables_other = tomap({
    for rtb_id in data.aws_route_tables.internal_other.ids :
    rtb_id => ""
  })
  other_routes_combined = merge([
    for rtb_id, _ in local.route_tables_other :
    {
      for route_name, route_values in var.tgw_other_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

  route_tables_other_tgw_only = tomap({
    for rtb_id in data.aws_route_tables.internal_other_tgw_only.ids :
    rtb_id => ""
  })
  other_tgw_only_routes_combined = merge([
    for rtb_id, _ in local.route_tables_other_tgw_only :
    {
      for route_name, route_values in var.tgw_other_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

  route_tables_fsx = tomap({
    for rtb_id in data.aws_route_tables.fsx.ids :
    rtb_id => ""
  })
  fsx_routes_combined = merge([
    for rtb_id, _ in local.route_tables_fsx :
    {
      for route_name, route_values in var.tgw_fsx_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

  route_tables_wsus = tomap({
    for rtb_id in data.aws_route_tables.internal_wsus.ids :
    rtb_id => ""
  })
  wsus_routes_combined = merge([
    for rtb_id, _ in local.route_tables_wsus :
    {
      for route_name, route_values in var.tgw_wsus_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)

route_tables_vgw = tomap({
    for rtb in concat(
      data.aws_route_tables.fsx.ids
    ) :
    rtb => ""
  })

  vgw_routes_combined = merge([
    for rtb_id, _ in local.route_tables_vgw :
    {
      for vgw_name, vgw_values in var.vgw_routes :
      "${vgw_name}-${rtb_id}" => merge(vgw_values, { rtb_id = rtb_id })
    }
  ]...)


 route_tables_peering = tomap({
    for rtb in concat(
      data.aws_route_tables.internal_db.ids,
      data.aws_route_tables.internal_app.ids,
      data.aws_route_tables.internal_other.ids,
      data.aws_route_tables.hscn_nlb.ids,
      data.aws_route_tables.internal_supp_services.ids
    ) :
    rtb => ""
  })

  wsus_route_tables_peering = tomap({
    for rtb in concat(
      data.aws_route_tables.internal_wsus.ids
    ) :
    rtb => ""
  })

  peering_routes_combined = merge([
    for rtb_id, _ in local.route_tables_peering :
    {
      for peering_name, peering_values in var.peering_routes :
      "${peering_name}-${rtb_id}" => merge(peering_values, { rtb_id = rtb_id })
    }
  ]...)

  wsus_peering_routes_combined = merge([
    for rtb_id, _ in local.wsus_route_tables_peering :
    {
      for peering_name, peering_values in var.wsus_peering_routes :
      "${peering_name}-${rtb_id}" => merge(peering_values, { rtb_id = rtb_id })
    }
  ]...)

  fsx_route_tables_peering = tomap({
    for rtb in concat(
      data.aws_route_tables.fsx.ids
    ) :
    rtb => ""
  })

  fsx_peering_routes_combined = merge([
    for rtb_id, _ in local.fsx_route_tables_peering :
    {
      for peering_name, peering_values in var.fsx_peering_routes :
      "${peering_name}-${rtb_id}" => merge(peering_values, { rtb_id = rtb_id })
    }
  ]...)

  route_tables_private = tomap({
    for rtb_id in data.aws_route_tables.private.ids :
    rtb_id => ""
  })

  private_routes_combined = merge([
    for rtb_id, _ in local.route_tables_private :
    {
      for route_name, route_values in var.tgw_private_routes :
      "${route_name}-${rtb_id}" => merge(route_values, { rtb_id = rtb_id })
    }
  ]...)
  private_subnets_peering_routes_combined = merge([
    for rtb_id, _ in local.route_tables_private :
    {
      for peering_name, peering_values in var.private_subnets_peering_routes :
      "${peering_name}-${rtb_id}" => merge(peering_values, { rtb_id = rtb_id })
    }
  ]...)
  
}