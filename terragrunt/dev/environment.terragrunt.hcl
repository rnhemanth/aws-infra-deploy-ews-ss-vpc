locals {
  common = read_terragrunt_config("${get_terragrunt_dir()}/../common.terragrunt.hcl")

  # Configure environment
  region                               = get_env("AWS_REGION")
  service                              = local.common.locals.service
  environment                          = get_env("ENVIRONMENT")
  project_name                         = "${local.environment}-${local.service}"
  region_prefix                        = format("%s%s%s", substr("${local.region}", 0, 2), substr("${local.region}", 3, 1), substr("${local.region}", 8, 1))
  ipv4_primary_cidr_block              = "100.68.36.0/22"
  ipv4_secondary_cidr_blocks           = []
  tgw_id_backbone                      = "tgw-0f28603fcaf843cb9"
  tgw_id_hscn                          = "tgw-0fae19691d80648cc"
  nat_gw_id_a                          = "nat-0a75c4b9022bdebf5"
  nat_gw_id_b                          = "nat-0836a882f7e1bfb11"
  peer_vpc_id                          = "vpc-0fa5ff8154e8b5f53"
  peer_region                          = "eu-west-2"
  peer_owner_id                        = "363541602858"
  peering_route_cidr_block             = ""
  england_peer_id                      = ""
  bastion_generic_cidr                 = ["100.68.52.0/28", "100.68.52.16/28"]
  bastion_migration_cidr               = ["100.68.52.32/28", "100.68.52.48/28"]
  shared_service_ad_cidr               = ["100.68.36.176/28", "100.68.38.32/28"]
  wsus_cidr                            = ["100.68.33.192/28", "100.68.33.208/28"]
  england_ad_cidr                      = ["100.68.32.176/28", "100.68.32.192/28"]
  delinea_cidr_block                   = "100.68.6.0/25"
  r53_outbound_endpoint_subnet         = "100.88.8.128/26"
  hscn_dns                             = ["155.231.231.1/32", "155.231.231.2/32"]
  netbackup_cidr_block                 = "100.68.5.64/26"
  peering_route_cidr_block_ss_bastions = "100.68.52.0/25"
  peering_route_sec_cidr_block_ss_bastion = "100.88.188.128/25"
  bastions_peer_id                     = "pcx-07512fbf8b4166084"
  firecracker_cidr_block               = "172.16.0.0/16"
  legacy_cidr_block                    = "44.0.0.0/8"
  onprem_cidr_block                    = "192.168.0.0/16"
  england_app_cidr_block               = ["100.68.32.80/28", "100.68.32.96/28"]
  on_prem_management_servers           = ["44.128.219.100/32", "44.128.211.206/32", "44.128.219.98/32", "44.128.203.206/32", "44.128.203.207/32"]
  awspatchstore_cidr_block             = ["100.68.32.208/28", "100.68.32.224/28"]
  ad_mgmt_security_group               = "sg-08199f34360e435f0"
  zscaler_cidr_block                   = ["185.46.212.92/32", "185.46.212.93/32", "104.129.193.65/32", "104.129.195.65/32", "104.129.197.65/32", "104.129.193.103/32", "104.129.195.103/32", "104.129.197.103/32"]
  exa_sg_cidr                          = "100.68.55.192/26"
  exa_sg_data_mesh_cidr                = "100.68.6.128/25"
  hda_cidr                             = ["100.68.39.64/28"]
  sentryone_cidr = ["100.68.37.55/32", "100.68.38.137/32"]

  name = {
    environment = "${local.environment}"
    service     = "${local.service}"
    identifier  = "${local.common.locals.service_location}"
  }

  tags = {
    environment = "${local.environment}"
    service     = "${local.service}"
    identifier  = "${local.common.locals.service_location}"
  }

  intra_subnets = {
    fsx = {
      fsx-2a = {
        cidr_block           = "100.68.39.16/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      fsx-2c = {
        cidr_block           = "100.68.39.0/28"
        availability_zone_id = "euw2-az1"
        hscn_connectivity    = "no"
      }
    }
    sql = {
      sql-2a = {
        cidr_block           = "100.68.37.64/26"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      sql-2b = {
        cidr_block           = "100.68.38.192/26"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
    sql-rs = {
      sql-rs-2a = {
        cidr_block           = "100.68.37.128/27"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
    }
    ss-apps = {
      ss-apps-2a = {
        cidr_block           = "100.68.36.192/26"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      ss-apps-2b = {
        cidr_block           = "100.68.38.64/26"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
    managed-ad = {
      managed-ad-2a = {
        cidr_block           = "100.68.36.176/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      managed-ad-2b = {
        cidr_block           = "100.68.38.32/28"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
    nlb-hscn = {
      nlb-hscn-2a = {
        cidr_block           = "100.68.36.128/27"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "yes"
      }
      nlb-hscn-2b = {
        cidr_block           = "100.68.38.0/27"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "yes"
      }
    }
    tgw-vpce = {
      tgw-vpce-2a = {
        cidr_block           = "100.68.36.160/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      tgw-vpce-2b = {
        cidr_block           = "100.68.38.48/28"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
      tgw-vpce-2c = {
        cidr_block           = "100.68.36.16/28"
        availability_zone_id = "euw2-az1"
        hscn_connectivity    = "no"
      }
    }
    wsus = {
      wsus-2a = {
        cidr_block           = "100.68.39.32/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      wsus-2b = {
        cidr_block           = "100.68.39.48/28"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
    supp-services = {
      supp-services-2a = {
        cidr_block           = "100.68.37.0/26"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      supp-services-2b = {
        cidr_block           = "100.68.38.128/26"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
    hda = {
      hda-2a = {
        cidr_block           = "100.68.39.64/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
    }
    rootca = {
      rootca-2a = {
        cidr_block           = "100.68.39.80/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
    }
    certauth = {
      certauth-2a = {
        cidr_block           = "100.68.39.96/28"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      certauth-2b = {
        cidr_block           = "100.68.39.112/28"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
  }

  private_subnets = {
    dmz = {
      eu-west-2a = {
        cidr_block           = "100.68.36.64/26"
        availability_zone_id = "euw2-az2"
        hscn_connectivity    = "no"
      }
      eu-west-2b = {
        cidr_block           = "100.68.37.192/26"
        availability_zone_id = "euw2-az3"
        hscn_connectivity    = "no"
      }
    }
  }

  public_subnets = {
    eu-west-2a = {
      cidr_block              = "100.68.36.32/27"
      availability_zone_id    = "euw2-az2"
      map_public_ip_on_launch = "no"
    }
    eu-west-2b = {
      cidr_block              = "100.68.37.160/27"
      availability_zone_id    = "euw2-az3"
      map_public_ip_on_launch = "no"
    }
  }

  route53_resolver_rules = {
    dev_england_emis_web_com = {
      rule_id = "rslvr-rr-6cefc1a34e264c61b"
    }
    dev_shared_services_emis_web_com = {
      rule_id = "rslvr-rr-4b6ebb37adf24a43b"
    }
    dev_iom_emis_web_com = {
      rule_id = "rslvr-rr-aa135d6f2ba942caa"
    }
    dev_scotland_emis_web_com = {
      rule_id = "rslvr-rr-f16106f88c1643ba8"
    }
    dev_ni_emis_web_com = {
      rule_id = "rslvr-rr-5577cdd9e26444f29"
    }
    dev_jersey_emis_web_com = {
      rule_id = "rslvr-rr-30add9483d65481e8"
    }
    awshosted_dev_emis-clinical_com = {
      rule_id = "rslvr-rr-d00835db9ec44e269"
    }
  }

  standard_sg_rules_cidr_blocks = {
    rule1  = { type = "ingress", from = 443, to = 443, protocol = "tcp", cidr = concat(["${local.ipv4_primary_cidr_block}"], local.ipv4_secondary_cidr_blocks), desc = "allow 443 inbound from VPC CIDR" }
    rule2  = { type = "ingress", from = 53, to = 53, protocol = "udp", cidr = concat(["${local.ipv4_primary_cidr_block}"], local.ipv4_secondary_cidr_blocks), desc = "Allow DNS in from VPC CIDR" }
    rule3  = { type = "egress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress rpc(Remote Procedure Call) traffic to AD subnet" }
    rule4  = { type = "egress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress NetBIOS traffic to AD subnet" }
    rule5  = { type = "egress", from = 3268, to = 3269, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress 3268-3269 traffic to AD subnet" }
    rule6  = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP ldap traffic to AD subnet" }
    rule7  = { type = "egress", from = 389, to = 389, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress UDP ldap traffic to AD subnet" }
    rule8  = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress SMB and Net Logon traffic to AD subnet" }
    rule9  = { type = "egress", from = 445, to = 445, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress SMB and Net Logon traffic to AD subnet" }
    rule10 = { type = "egress", from = 464, to = 464, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP kerberos traffic to AD subnet" }
    rule11 = { type = "egress", from = 49152, to = 65535, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress 49152-65535 traffic to AD subnet" }
    rule12 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress DNS traffic to AD subnet" }
    rule13 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress DNS traffic to AD subnet" }
    rule14 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = concat(["${local.ipv4_primary_cidr_block}"], local.ipv4_secondary_cidr_blocks), desc = "egress internal VPC UDP DNS traffic" }
    rule15 = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP ldaps traffic to AD subnet" }
    rule16 = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP Kerberos Key Distribution Center traffic to AD subnet" }
    rule17 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.r53_outbound_endpoint_subnet}"], desc = "Allow DNS outbound to networks services route 53 resolver endpoint" }
    rule18 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = "${local.hscn_dns}", desc = "Allow DNS outbound udp to HSCN" }
    rule19 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = "${local.hscn_dns}", desc = "Allow DNS outbound tcp to HSCN" }
    rule20 = { type = "ingress", from = 53, to = 53, protocol = "udp", cidr = ["${local.r53_outbound_endpoint_subnet}"], desc = "Allow DNS in from networks services route 53 resolver endpoint" }
    rule21 = { type = "ingress", from = 3389, to = 3389, protocol = "tcp", cidr = ["${local.delinea_cidr_block}"], desc = "Allow RDP in from Delinea Distributed Engine CIDR" }
    rule22 = { type = "ingress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.bastion_generic_cidr}", desc = "Allow TCP 5985 from Generic Bastion Subnets" }
    rule23 = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = "${local.bastion_generic_cidr}", desc = "Allow TCP 135 from Generic Bastion Subnets" }
    rule24 = { type = "egress", from = 8530, to = 8531, protocol = "tcp", cidr = "${local.wsus_cidr}", desc = "Allow TCP 8530 - 8531 to WSUS" }
    rule25 = { type = "ingress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.bastion_migration_cidr}", desc = "Allow TCP 5985 from Migration Bastion Subnets" }
    rule26 = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = "${local.bastion_migration_cidr}", desc = "Allow TCP 135 from Migration Bastion Subnets" }
    rule27 = { type = "egress", from = 88, to = 88, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress UDP Kerberos Key Distribution Center traffic to AD subnet" }
    rule28 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = concat(["${local.ipv4_primary_cidr_block}"], local.ipv4_secondary_cidr_blocks), desc = "Allow 443 outbound" }
    rule29 = { type = "egress", from = 123, to = 123, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "NTP time sync to DCs" }
    rule30 = { type = "egress", from = 587, to = 587, protocol = "tcp", cidr = concat(["${local.ipv4_primary_cidr_block}"]), desc = "SMTP access" }
    rule31 = { type = "egress", from = 88, to = 88, protocol = "udp", cidr = "${local.england_ad_cidr}", desc = "Allow UDP 88 to Kerberos england AD subnet" }
    rule32 = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP 88 to Kerberos england AD subnet" }
    rule33 = { type = "egress", from = 135, to = 135, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP 135 to RPC england AD subnet" }
    rule34 = { type = "egress", from = 139, to = 139, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP 139 to NetBios england AD subnet" }
    rule35 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP 445 to SMB england AD subnet" }
    rule36 = { type = "egress", from = 445, to = 445, protocol = "udp", cidr = "${local.england_ad_cidr}", desc = "Allow UDP 445 to SMB england AD subnet" }
    rule37 = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP 389 to LDAP england AD subnet" }
    rule38 = { type = "egress", from = 389, to = 389, protocol = "udp", cidr = "${local.england_ad_cidr}", desc = "Allow UDP 389 to LDAP england AD subnet" }
    rule39 = { type = "egress", from = 49152, to = 65535, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP to apps england AD subnet" }
    rule40 = { type = "egress", from = 464, to = 464, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP to AD england AD subnet" }
    rule41 = { type = "egress", from = 3268, to = 3269, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP to AD england AD subnet" }
    rule42 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP 53 to DNS england AD subnet" }
    rule43 = { type = "egress", from = 53, to = 53, protocol = "UDP", cidr = "${local.england_ad_cidr}", desc = "Allow UDP 53 to DNS england AD subnet" }
    rule44 = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = "${local.england_ad_cidr}", desc = "Allow TCP ldaps to DNS england AD subnet" }
    rule45 = { type = "egress", from = 123, to = 123, protocol = "UDP", cidr = "${local.england_ad_cidr}", desc = "Allow TCP NTP time sync to DNS england AD subnet" }
  }

  db_sg_rules_cidr_blocks = {
    rule1 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.intra_subnets.fsx["fsx-2c"].cidr_block}", "${local.intra_subnets.fsx["fsx-2a"].cidr_block}"], desc = "FSx - SMB" }
    rule2 = { type = "egress", from = 5985, to = 5985, protocol = "tcp", cidr = ["${local.intra_subnets.fsx["fsx-2c"].cidr_block}", "${local.intra_subnets.fsx["fsx-2a"].cidr_block}"], desc = "FSx - WinRM-http" }
    rule3 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow all egress https traffic" }
    rule4 = { type = "ingress", from = 1430, to = 1440, protocol = "tcp", cidr = "${local.bastion_generic_cidr}", desc = "Allow TCP 1430 from Generic Bastion Subnets" }
    rule5 = { type = "ingress", from = 0, to = 65535, protocol = "udp", cidr = "${local.bastion_generic_cidr}", desc = "Allow all UDP from Generic Bastion Subnets" }
    rule6 = { type = "ingress", from = 49152, to = 65535, protocol = "tcp", cidr = "${local.bastion_generic_cidr}", desc = "Allow TCP 49152 from Generic Bastion Subnets" }
    rule7 = { type = "ingress", from = 1430, to = 1440, protocol = "tcp", cidr = "${local.bastion_migration_cidr}", desc = "Allow TCP 1430 from Migration Bastion Subnets" }
    rule8 = { type = "ingress", from = 0, to = 65535, protocol = "udp", cidr = "${local.bastion_migration_cidr}", desc = "Allow all UDP from Migration Bastion Subnets" }
    rule9 = { type = "ingress", from = 49152, to = 65535, protocol = "tcp", cidr = "${local.bastion_migration_cidr}", desc = "Allow TCP 49152 from Migration Bastion Subnets" }
    rule10 = { type = "ingress", from = 1433, to = 1434, protocol = "tcp", cidr = "${local.hda_cidr}", desc = "Allow TCP 1433 to 1434 inbound from HDA Subnets" }
    rule11 = { type = "ingress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.hda_cidr}", desc = "Allow TCP 5985 to 5986 inbound from HDA Subnets" }
    rule12 = { type = "ingress", from = 1433, to = 1433, protocol = "tcp", cidr = "${local.sentryone_cidr}" , desc = "Allow TCP 1433 inbound from SentryOne apps" }
    rule13 = { type = "ingress", from = 445, to = 445, protocol = "tcp", cidr = "${local.sentryone_cidr}" , desc = "Allow TCP 445 inbound from SentryOne apps" }
    rule14 = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = "${local.sentryone_cidr}" , desc = "Allow TCP 135 inbound from SentryOne apps" }
    rule15 = { type = "ingress", from = 49152, to = 65535, protocol = "tcp", cidr = "${local.sentryone_cidr}" , desc = "Allow TCP 49152 - 65535 inbound from SentryOne apps" }
  }

  db_sg_rules_self = {
    rule1 = { type = "egress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - db tier" }
    rule2 = { type = "ingress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - db tier" }
  }

  db_sg_rules_security_group = {
    rule1 = { type = "ingress", from = 0, to = 0, protocol = "-1", source_sg = "${local.ad_mgmt_security_group}", desc = "Allow all traffic between AD Management" }
  }

  app_sg_rules_cidr_blocks = {
    rule1  = { type = "ingress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.intra_subnets.nlb-hscn["nlb-hscn-2a"].cidr_block}", "${local.intra_subnets.nlb-hscn["nlb-hscn-2b"].cidr_block}"], desc = "Allow NLB Access - 8085" }
    rule2  = { type = "ingress", from = 3031, to = 3031, protocol = "tcp", cidr = ["${local.intra_subnets.nlb-hscn["nlb-hscn-2a"].cidr_block}", "${local.intra_subnets.nlb-hscn["nlb-hscn-2b"].cidr_block}"], desc = "Allow NLB Access - 3031" }
    rule3  = { type = "ingress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.intra_subnets.nlb-hscn["nlb-hscn-2a"].cidr_block}", "${local.intra_subnets.nlb-hscn["nlb-hscn-2b"].cidr_block}"], desc = "Allow NLB Access - 33950 to 33999" }
    rule4  = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow all egress https traffic" }
    rule5  = { type = "egress", from = 33950, to = 33999, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow EMIS ports outbound everywhere" }
    rule6  = { type = "egress", from = 80, to = 80, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow 80 outbound everywhere" }
    rule7  = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow 389 outbound everywhere" }
    rule8  = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow 636 outbound everywhere" }
    rule9  = { type = "egress", from = 8082, to = 8082, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow Notification Services port outbound everywhere" }
    rule10 = { type = "egress", from = 5672, to = 5672, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow Rabbit MQ Services port outbound everywhere" }
    rule11 = { type = "egress", from = 17000, to = 17000, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow Redis Cache Services port outbound everywhere" }
    rule12 = { type = "egress", from = 15672, to = 15672, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow Resilience queue Services port outbound everywhere" }
  }

  app_sg_rules_self = {
    rule1 = { type = "egress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - app tier" }
    rule2 = { type = "ingress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - app tier" }
  }

  app_sg_rules_security_group = {
    rule1 = { type = "ingress", from = 0, to = 0, protocol = "-1", source_sg = "${local.ad_mgmt_security_group}", desc = "Allow all traffic between AD Management" }
  }

  awspatchstore_sg_rules_cidr_block = {
    rule1 = { type = "egress", from = 33963, to = 33963, protocol = "tcp", cidr = "${local.awspatchstore_cidr_block}", desc = "Allow TCP 33963 to AWS Patch Stores" }
    rule2 = { type = "egress", from = 80, to = 80, protocol = "tcp", cidr = "${local.awspatchstore_cidr_block}", desc = "Allow TCP 80 to AWS Patch Stores" }
    rule3 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = "${local.awspatchstore_cidr_block}", desc = "Allow TCP 443 to AWS Patch Stores" }
  }


  sds_sg_rules_cidr_block = {
    rule1 = { type = "egress", from = 33962, to = 33963, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow TCP 33962 and 33963 to any Patch Stores" }
    rule2 = { type = "egress", from = 33956, to = 33956, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow TCP 33956 to any product manager" }
    rule3 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.intra_subnets.fsx["fsx-2c"].cidr_block}", "${local.intra_subnets.fsx["fsx-2a"].cidr_block}"], desc = "Allow SMB to FSx" }
  }


  backup_sg_rules_cidr_blocks = {
    rule1 = { type = "ingress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 1556 from netbackup" }
    rule2 = { type = "ingress", from = 10082, to = 10082, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 10082 from netbackup" }
    rule3 = { type = "ingress", from = 10102, to = 10102, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 10102 from netbackup" }
    rule4 = { type = "ingress", from = 13724, to = 13724, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 13724 from netbackup" }
    rule5 = { type = "egress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 1556 to netbackup" }
    rule6 = { type = "egress", from = 10082, to = 10082, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 10082 to netbackup" }
    rule7 = { type = "egress", from = 10102, to = 10102, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 10102 to netbackup" }
    rule8 = { type = "egress", from = 13724, to = 13724, protocol = "tcp", cidr = ["${local.netbackup_cidr_block}"], desc = "Allow TCP 13724 to netbackup" }
  }

  backup_sg_rules_self = {
    rule1 = { type = "egress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - backup" }
    rule2 = { type = "ingress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - backup" }
  }

  firecracker_sg_rules_cidr_blocks = {
    rule1  = { type = "ingress", from = 50400, to = 50400, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 50400 from firecracker on-prem" }
    rule2  = { type = "ingress", from = 33956, to = 33956, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 33956 from firecracker on-prem" }
    rule3  = { type = "ingress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 53 from firecracker on-prem" }
    rule4  = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 135 from firecracker on-prem" }
    rule5  = { type = "ingress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP EmisWeb & SDS from firecracker on-prem" }
    rule6  = { type = "ingress", from = 3268, to = 3268, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 3268 from firecracker on-prem" }
    rule7  = { type = "ingress", from = 1374, to = 1374, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 1374 from firecracker on-prem" }
    rule8  = { type = "ingress", from = 135, to = 135, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 135 from firecracker on-prem" }
    rule9  = { type = "ingress", from = 53, to = 53, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 53 from firecracker on-prem" }
    rule10 = { type = "ingress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.firecracker_cidr_block}"], desc = "Ping from firecracker on-prem" }
    rule11 = { type = "ingress", from = 52732, to = 52732, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 52732 from firecracker on-prem" }
    rule12 = { type = "ingress", from = 137, to = 137, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 137 from firecracker on-prem" }
    rule13 = { type = "ingress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 1433 from firecracker on-prem" }
    rule14 = { type = "ingress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 1556 from firecracker on-prem" }
    rule15 = { type = "ingress", from = 5001, to = 5001, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 5001 from firecracker on-prem" }
    rule16 = { type = "ingress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 389 from firecracker on-prem" }
    rule17 = { type = "ingress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 636 from firecracker on-prem" }
    rule18 = { type = "ingress", from = 8082, to = 8082, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8082 from firecracker on-prem" }
    rule19 = { type = "ingress", from = 445, to = 445, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 445 from firecracker on-prem" }
    rule20 = { type = "ingress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 88 from firecracker on-prem" }
    rule21 = { type = "ingress", from = 5002, to = 5002, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 5002 from firecracker on-prem" }
    rule22 = { type = "ingress", from = 8125, to = 8125, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8125 from firecracker on-prem" }
    rule23 = { type = "ingress", from = 5000, to = 5000, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 5000 from firecracker on-prem" }
    rule24 = { type = "ingress", from = 88, to = 88, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 88 from firecracker on-prem" }
    rule25 = { type = "ingress", from = 389, to = 389, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 389 from firecracker on-prem" }
    rule26 = { type = "ingress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 443 from firecracker on-prem" }
    rule27 = { type = "ingress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 445 from firecracker on-prem" }
    rule28 = { type = "ingress", from = 3128, to = 3128, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 3128 from firecracker on-prem" }
    rule29 = { type = "ingress", from = 8834, to = 8834, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8834 from firecracker on-prem" }
    rule30 = { type = "ingress", from = 3269, to = 3269, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 3269 from firecracker on-prem" }
    rule31 = { type = "ingress", from = 138, to = 138, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 138 from firecracker on-prem" }
    rule32 = { type = "ingress", from = 25, to = 25, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 25 from firecracker on-prem" }
    rule33 = { type = "ingress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 139 from firecracker on-prem" }
    rule34 = { type = "ingress", from = 1434, to = 1434, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 1434 from firecracker on-prem" }
    rule35 = { type = "ingress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8085 from firecracker on-prem" }
    rule36 = { type = "egress", from = 50400, to = 50400, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 50400 to firecracker on-prem" }
    rule37 = { type = "egress", from = 33956, to = 33956, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 33956 to firecracker on-prem" }
    rule38 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 53 to firecracker on-prem" }
    rule39 = { type = "egress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 135 to firecracker on-prem" }
    rule40 = { type = "egress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP EmisWeb & SDS to firecracker on-prem" }
    rule41 = { type = "egress", from = 3268, to = 3268, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 3268 to firecracker on-prem" }
    rule42 = { type = "egress", from = 1374, to = 1374, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 1374 to firecracker on-prem" }
    rule43 = { type = "egress", from = 135, to = 135, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 135 to firecracker on-prem" }
    rule44 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 53 to firecracker on-prem" }
    rule45 = { type = "egress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.firecracker_cidr_block}"], desc = "Ping to firecracker on-prem" }
    rule46 = { type = "egress", from = 52732, to = 52732, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 52732 to firecracker on-prem" }
    rule47 = { type = "egress", from = 137, to = 137, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 137 to firecracker on-prem" }
    rule48 = { type = "egress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 1433 to firecracker on-prem" }
    rule49 = { type = "egress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 1556 to firecracker on-prem" }
    rule50 = { type = "egress", from = 5001, to = 5001, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 5001 to firecracker on-prem" }
    rule51 = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 389 to firecracker on-prem" }
    rule52 = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 636 to firecracker on-prem" }
    rule53 = { type = "egress", from = 8082, to = 8082, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8082 to firecracker on-prem" }
    rule54 = { type = "egress", from = 445, to = 445, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 445 to firecracker on-prem" }
    rule55 = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 88 to firecracker on-prem" }
    rule56 = { type = "egress", from = 5002, to = 5002, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 5002 to firecracker on-prem" }
    rule57 = { type = "egress", from = 8125, to = 8125, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8125 to firecracker on-prem" }
    rule58 = { type = "egress", from = 5000, to = 5000, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 5000 to firecracker on-prem" }
    rule59 = { type = "egress", from = 88, to = 88, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 88 to firecracker on-prem" }
    rule60 = { type = "egress", from = 389, to = 389, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 389 to firecracker on-prem" }
    rule61 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 443 to firecracker on-prem" }
    rule62 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 445 to firecracker on-prem" }
    rule63 = { type = "egress", from = 3128, to = 3128, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 3128 to firecracker on-prem" }
    rule64 = { type = "egress", from = 8834, to = 8834, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8834 to firecracker on-prem" }
    rule65 = { type = "egress", from = 3269, to = 3269, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 3269 to firecracker on-prem" }
    rule66 = { type = "egress", from = 138, to = 138, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 138 to firecracker on-prem" }
    rule67 = { type = "egress", from = 25, to = 25, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 25 to firecracker on-prem" }
    rule68 = { type = "egress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 139 to firecracker on-prem" }
    rule69 = { type = "egress", from = 1434, to = 1434, protocol = "udp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow UDP 1434 to firecracker on-prem" }
    rule70 = { type = "egress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.firecracker_cidr_block}"], desc = "Allow TCP 8085 to firecracker on-prem" }
  }

  firecracker_sg_rules_self = {
    rule1 = { type = "egress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - firecracker" }
    rule2 = { type = "ingress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - firecracker" }
  }

  legacy_sg_rules_cidr_blocks = {
    rule1  = { type = "ingress", from = 50400, to = 50400, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 50400 from legacy on-prem" }
    rule2  = { type = "ingress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 53 from legacy on-prem" }
    rule3  = { type = "ingress", from = 52732, to = 52732, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 52732 from legacy on-prem" }
    rule4  = { type = "ingress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 88 from legacy on-prem" }
    rule5  = { type = "ingress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 1556 from legacy on-prem" }
    rule6  = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 135 from legacy on-prem" }
    rule7  = { type = "ingress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.legacy_cidr_block}"], desc = "Ping from legacy on-prem" }
    rule8  = { type = "ingress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 1433 from legacy on-prem" }
    rule9  = { type = "ingress", from = 3268, to = 3268, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 3268 from legacy on-prem" }
    rule10 = { type = "ingress", from = 135, to = 135, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 135 from legacy on-prem" }
    rule11 = { type = "ingress", from = 5001, to = 5001, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 5001 from legacy on-prem" }
    rule12 = { type = "ingress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 443 from legacy on-prem" }
    rule13 = { type = "ingress", from = 3269, to = 3269, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 3269 from legacy on-prem" }
    rule14 = { type = "ingress", from = 3128, to = 3128, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 3128 from legacy on-prem" }
    rule15 = { type = "ingress", from = 53, to = 53, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 53 from legacy on-prem" }
    rule16 = { type = "ingress", from = 5000, to = 5000, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 5000 from legacy on-prem" }
    rule17 = { type = "ingress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 139 from legacy on-prem" }
    rule18 = { type = "ingress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 445 from legacy on-prem" }
    rule19 = { type = "ingress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8085 from legacy on-prem" }
    rule20 = { type = "ingress", from = 1434, to = 1434, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 1434 from legacy on-prem" }
    rule21 = { type = "ingress", from = 445, to = 445, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 445 from legacy on-prem" }
    rule22 = { type = "ingress", from = 8834, to = 8834, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8834 from legacy on-prem" }
    rule23 = { type = "ingress", from = 137, to = 137, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 137 from legacy on-prem" }
    rule24 = { type = "ingress", from = 8125, to = 8125, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8125 from legacy on-prem" }
    rule25 = { type = "ingress", from = 33956, to = 33956, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 33956 from legacy on-prem" }
    rule26 = { type = "ingress", from = 138, to = 138, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 138 from legacy on-prem" }
    rule27 = { type = "ingress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 389 from legacy on-prem" }
    rule28 = { type = "ingress", from = 49152, to = 65535, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Dynamic range from legacy on-prem" }
    rule29 = { type = "ingress", from = 8082, to = 8082, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8082 from legacy on-prem" }
    rule30 = { type = "ingress", from = 5002, to = 5002, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 5002 from legacy on-prem" }
    rule31 = { type = "ingress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 636 from legacy on-prem" }
    rule32 = { type = "ingress", from = 88, to = 88, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 88 from legacy on-prem" }
    rule33 = { type = "ingress", from = 389, to = 389, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 389 from legacy on-prem" }
    rule34 = { type = "ingress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP EmisWeb & SDS from legacy on-prem" }
    rule35 = { type = "ingress", from = 1374, to = 1374, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 1374 from legacy on-prem" }
    rule36 = { type = "ingress", from = 25, to = 25, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 25 from legacy on-prem" }
    rule37 = { type = "egress", from = 50400, to = 50400, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 50400 to legacy on-prem" }
    rule38 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 53 to legacy on-prem" }
    rule39 = { type = "egress", from = 52732, to = 52732, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 52732 to legacy on-prem" }
    rule40 = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 88 to legacy on-prem" }
    rule41 = { type = "egress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 1556 to legacy on-prem" }
    rule42 = { type = "egress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 135 to legacy on-prem" }
    rule43 = { type = "egress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.legacy_cidr_block}"], desc = "Ping to legacy on-prem" }
    rule44 = { type = "egress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 1433 to legacy on-prem" }
    rule45 = { type = "egress", from = 3268, to = 3268, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 3268 to legacy on-prem" }
    rule46 = { type = "egress", from = 135, to = 135, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 135 to legacy on-prem" }
    rule47 = { type = "egress", from = 5001, to = 5001, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 5001 to legacy on-prem" }
    rule48 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 443 to legacy on-prem" }
    rule49 = { type = "egress", from = 3269, to = 3269, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 3269 to legacy on-prem" }
    rule50 = { type = "egress", from = 3128, to = 3128, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 3128 to legacy on-prem" }
    rule51 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 53 to legacy on-prem" }
    rule52 = { type = "egress", from = 5000, to = 5000, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 5000 to legacy on-prem" }
    rule53 = { type = "egress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 139 to legacy on-prem" }
    rule54 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 445 to legacy on-prem" }
    rule55 = { type = "egress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8085 to legacy on-prem" }
    rule56 = { type = "egress", from = 1434, to = 1434, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 1434 to legacy on-prem" }
    rule57 = { type = "egress", from = 445, to = 445, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 445 to legacy on-prem" }
    rule58 = { type = "egress", from = 8834, to = 8834, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8834 to legacy on-prem" }
    rule59 = { type = "egress", from = 137, to = 137, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 137 to legacy on-prem" }
    rule60 = { type = "egress", from = 8125, to = 8125, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8125 to legacy on-prem" }
    rule61 = { type = "egress", from = 33956, to = 33956, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 33956 to legacy on-prem" }
    rule62 = { type = "egress", from = 138, to = 138, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 138 to legacy on-prem" }
    rule63 = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 389 to legacy on-prem" }
    rule64 = { type = "egress", from = 49152, to = 65535, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Dynamic range to legacy on-prem" }
    rule65 = { type = "egress", from = 8082, to = 8082, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 8082 to legacy on-prem" }
    rule66 = { type = "egress", from = 5002, to = 5002, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 5002 to legacy on-prem" }
    rule67 = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 636 to legacy on-prem" }
    rule68 = { type = "egress", from = 88, to = 88, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 88 to legacy on-prem" }
    rule69 = { type = "egress", from = 389, to = 389, protocol = "udp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow UDP 389 to legacy on-prem" }
    rule70 = { type = "egress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP EmisWeb & SDS to legacy on-prem" }
    rule71 = { type = "egress", from = 1374, to = 1374, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 1374 to legacy on-prem" }
    rule72 = { type = "egress", from = 25, to = 25, protocol = "tcp", cidr = ["${local.legacy_cidr_block}"], desc = "Allow TCP 25 to legacy on-prem" }
    rule73 = { type = "ingress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.on_prem_management_servers}", desc = "Allow WinRM from on-prem management servers" }
    rule74 = { type = "egress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.on_prem_management_servers}", desc = "Allow WinRM to on-prem management servers" }
  }

  legacy_sg_rules_self = {
    rule1 = { type = "egress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - legacy" }
    rule2 = { type = "ingress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - legacy" }
  }

  onprem_sg_rules_cidr_blocks = {
    rule1  = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 135 from on-prem" }
    rule2  = { type = "ingress", from = 1374, to = 1374, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1374 from on-prem" }
    rule3  = { type = "ingress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 139 from on-prem" }
    rule4  = { type = "ingress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1433 from on-prem" }
    rule5  = { type = "ingress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1556 from on-prem" }
    rule6  = { type = "ingress", from = 25, to = 25, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1556 from on-prem" }
    rule7  = { type = "ingress", from = 3128, to = 3128, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 3128 from on-prem" }
    rule8  = { type = "ingress", from = 3268, to = 3268, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 3268 from on-prem" }
    rule9  = { type = "ingress", from = 3269, to = 3269, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 3269 from on-prem" }
    rule10 = { type = "ingress", from = 33956, to = 33956, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 33956 from on-prem" }
    rule11 = { type = "ingress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 389 from on-prem" }
    rule12 = { type = "ingress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 443 from on-prem" }
    rule13 = { type = "ingress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 445 from on-prem" }
    rule14 = { type = "ingress", from = 5000, to = 5000, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 5000 from on-prem" }
    rule15 = { type = "ingress", from = 5001, to = 5001, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 5001 from on-prem" }
    rule16 = { type = "ingress", from = 5002, to = 5002, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 5002 from on-prem" }
    rule17 = { type = "ingress", from = 50400, to = 50400, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 50400 from on-prem" }
    rule18 = { type = "ingress", from = 52732, to = 52732, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 52732 from on-prem" }
    rule19 = { type = "ingress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 53 from on-prem" }
    rule20 = { type = "ingress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 636 from on-prem" }
    rule21 = { type = "ingress", from = 8082, to = 8082, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8082 from on-prem" }
    rule22 = { type = "ingress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8085 from on-prem" }
    rule23 = { type = "ingress", from = 8125, to = 8125, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8125 from on-prem" }
    rule24 = { type = "ingress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 88 from on-prem" }
    rule25 = { type = "ingress", from = 8834, to = 8834, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8834 from on-prem" }
    rule26 = { type = "ingress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP EmisWeb & SDS from on-prem" }
    rule27 = { type = "ingress", from = 135, to = 135, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 135 from on-prem" }
    rule28 = { type = "ingress", from = 137, to = 137, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 137 from on-prem" }
    rule29 = { type = "ingress", from = 138, to = 138, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 138 from on-prem" }
    rule30 = { type = "ingress", from = 1434, to = 1434, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 1434 from on-prem" }
    rule31 = { type = "ingress", from = 389, to = 389, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 389 from on-prem" }
    rule32 = { type = "ingress", from = 445, to = 445, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 445 from on-prem" }
    rule33 = { type = "ingress", from = 53, to = 53, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 53 from on-prem" }
    rule34 = { type = "ingress", from = 88, to = 88, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 88 from on-prem" }
    rule35 = { type = "ingress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.onprem_cidr_block}"], desc = "Ping from on-prem" }
    rule36 = { type = "egress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 135 to on-prem" }
    rule37 = { type = "egress", from = 1374, to = 1374, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1374 to on-prem" }
    rule38 = { type = "egress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 139 to on-prem" }
    rule39 = { type = "egress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1433 to on-prem" }
    rule40 = { type = "egress", from = 1556, to = 1556, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1556 to on-prem" }
    rule41 = { type = "egress", from = 25, to = 25, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 1556 to on-prem" }
    rule42 = { type = "egress", from = 3128, to = 3128, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 3128 to on-prem" }
    rule43 = { type = "egress", from = 3268, to = 3268, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 3268 to on-prem" }
    rule44 = { type = "egress", from = 3269, to = 3269, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 3269 to on-prem" }
    rule45 = { type = "egress", from = 33956, to = 33956, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 33956 to on-prem" }
    rule46 = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 389 to on-prem" }
    rule47 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 443 to on-prem" }
    rule48 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 445 to on-prem" }
    rule49 = { type = "egress", from = 5000, to = 5000, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 5000 to on-prem" }
    rule50 = { type = "egress", from = 5001, to = 5001, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 5001 to on-prem" }
    rule51 = { type = "egress", from = 5002, to = 5002, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 5002 to on-prem" }
    rule52 = { type = "egress", from = 50400, to = 50400, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 50400 to on-prem" }
    rule53 = { type = "egress", from = 52732, to = 52732, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 52732 to on-prem" }
    rule54 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 53 to on-prem" }
    rule55 = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 636 to on-prem" }
    rule56 = { type = "egress", from = 8082, to = 8082, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8082 to on-prem" }
    rule57 = { type = "egress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8085 to on-prem" }
    rule58 = { type = "egress", from = 8125, to = 8125, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8125 to on-prem" }
    rule59 = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 88 to on-prem" }
    rule60 = { type = "egress", from = 8834, to = 8834, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP 8834 to on-prem" }
    rule61 = { type = "egress", from = 33950, to = 33999, protocol = "tcp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow TCP EmisWeb & SDS to on-prem" }
    rule62 = { type = "egress", from = 135, to = 135, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 135 to on-prem" }
    rule63 = { type = "egress", from = 137, to = 137, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 137 to on-prem" }
    rule64 = { type = "egress", from = 138, to = 138, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 138 to on-prem" }
    rule65 = { type = "egress", from = 1434, to = 1434, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 1434 to on-prem" }
    rule66 = { type = "egress", from = 389, to = 389, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 389 to on-prem" }
    rule67 = { type = "egress", from = 445, to = 445, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 445 to on-prem" }
    rule68 = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 53 to on-prem" }
    rule69 = { type = "egress", from = 88, to = 88, protocol = "udp", cidr = ["${local.onprem_cidr_block}"], desc = "Allow UDP 88 to on-prem" }
    rule70 = { type = "egress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.onprem_cidr_block}"], desc = "Ping to on-prem" }
  }

  private_sg_rules_self = {
    rule1 = { type = "egress", from = 443, to = 443, protocol = "tcp", self = true, desc = "Allow all 443 traffic within SG - private" }
    rule2 = { type = "ingress", from = 443, to = 443, protocol = "tcp", self = true, desc = "Allow all 443 traffic within SG - private" }
  }

  private_sg_rules_cidr_block = {
    rule1  = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress DNS traffic to AD subnet" }
    rule2  = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress DNS traffic to AD subnet" }
    rule3  = { type = "egress", from = 53, to = 53, protocol = "udp", cidr = ["${local.r53_outbound_endpoint_subnet}"], desc = "Allow DNS outbound to networks services route 53 resolver endpoint" }
    rule4  = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP Kerberos Key Distribution Center traffic to AD subnet" }
    rule5  = { type = "egress", from = 123, to = 123, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "NTP time sync to DCs" }
    rule6  = { type = "egress", from = 135, to = 135, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress rpc(Remote Procedure Call) traffic to AD subnet" }
    rule7  = { type = "egress", from = 139, to = 139, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress NetBIOS traffic to AD subnet" }
    rule8  = { type = "egress", from = 389, to = 389, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP ldap traffic to AD subnet" }
    rule9  = { type = "egress", from = 389, to = 389, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress UDP ldap traffic to AD subnet" }
    rule10 = { type = "egress", from = 443, to = 443, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow traffic from private CIDR block to 443 everywhere" }
    rule11 = { type = "egress", from = 445, to = 445, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress SMB and Net Logon traffic to AD subnet" }
    rule12 = { type = "egress", from = 636, to = 636, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress TCP ldaps traffic to AD subnet" }
    rule13 = { type = "egress", from = 636, to = 636, protocol = "udp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress UDP ldaps traffic to AD subnet" }
    rule14 = { type = "egress", from = 8530, to = 8531, protocol = "tcp", cidr = "${local.wsus_cidr}", desc = "Allow TCP 8530 - 8531 to WSUS" }
    rule15 = { type = "egress", from = 49152, to = 65535, protocol = "tcp", cidr = ["${local.intra_subnets.managed-ad["managed-ad-2b"].cidr_block}", "${local.intra_subnets.managed-ad["managed-ad-2a"].cidr_block}"], desc = "egress 49152-65535 traffic to AD subnet" }
    rule16 = { type = "ingress", from = 443, to = 443, protocol = "tcp", cidr = ["${local.public_subnets["eu-west-2a"].cidr_block}", "${local.public_subnets["eu-west-2b"].cidr_block}"], desc = "Allow 443 traffic in from public NLB CIDR block" }
    rule17 = { type = "ingress", from = 3389, to = 3389, protocol = "tcp", cidr = ["${local.delinea_cidr_block}"], desc = "Allow RDP in from Delinea Distributed Engine CIDR" }
    rule18 = { type = "ingress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.bastion_generic_cidr}", desc = "Allow TCP 5985 from Generic Bastion Subnets" }
    rule19 = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = "${local.bastion_generic_cidr}", desc = "Allow TCP 135 from Generic Bastion Subnets" }
    rule20 = { type = "ingress", from = 5985, to = 5986, protocol = "tcp", cidr = "${local.bastion_migration_cidr}", desc = "Allow TCP 5985 from Migration Bastion Subnets" }
    rule21 = { type = "ingress", from = 135, to = 135, protocol = "tcp", cidr = "${local.bastion_migration_cidr}", desc = "Allow TCP 135 from Migration Bastion Subnets" }
  }

  legacy_sds_sg_rules_cidr_block = {
    rule1 = { type = "egress", from = 33962, to = 33962, protocol = "tcp", cidr = ["44.128.196.12/32"], desc = "Allow TCP 33962 to PM" }
    rule2 = { type = "egress", from = 33963, to = 33963, protocol = "tcp", cidr = ["0.0.0.0/0"], desc = "Allow TCP 33963 to any Patch Stores" }
    rule3 = { type = "egress", from = 33956, to = 33956, protocol = "tcp", cidr = ["44.128.196.12/32"], desc = "Allow TCP 33956 to PM" }
  }

  oapi_sg_rules_cidr_block = {
    rule1 = { type = "egress", from = 8085, to = 8085, protocol = "tcp", cidr = ["${local.onprem_cidr_block}", "${local.legacy_cidr_block}", "${local.firecracker_cidr_block}"], desc = "Allow traffic from private CIDR block to 8085 on-prem" }
    rule2 = { type = "egress", from = 8085, to = 8085, protocol = "tcp", cidr = "${local.england_app_cidr_block}", desc = "Allow traffic from private CIDR block to 8085 england app subnets" }
  }

  exa_sg_rules_cidr_blocks = {
    rule1 = { type = "ingress", from = 49152, to = 65535, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow EXA access to SQL dynamic ports" }
    rule2 = { type = "ingress", from = 0, to = 65535, protocol = "udp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow EXA access to SQL dynamic ports" }
    rule3 = { type = "ingress", from = 1430, to = 1440, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow EXA reps to connect to browser service"  }
    rule4 = { type = "ingress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow TCP 88 from EXA" }
    rule5 = { type = "ingress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.exa_sg_cidr}","${local.exa_sg_data_mesh_cidr}"], desc = "Allow TCP 1433 from EXA and EXA Data Mesh" }
    rule6 = { type = "ingress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow TCP 53 from EXA" }
    rule7 = { type = "egress", from = 88, to = 88, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow TCP 88 to EXA"  }
    rule8 = { type = "egress", from = 1433, to = 1433, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow TCP 1433 to EXA" }
    rule9 = { type = "egress", from = 53, to = 53, protocol = "tcp", cidr = ["${local.exa_sg_cidr}"], desc = "Allow TCP 53 to EXA" }
    rule10 = { type = "ingress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.exa_sg_cidr}"], desc = "Ping from EXA" }
    rule11 = { type = "egress", from = 8, to = 0, protocol = "icmp", cidr = ["${local.exa_sg_cidr}"], desc = "Ping to EXA" }
  }

  exa_sg_rules_self = {
    rule1 = { type = "egress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - exa" }
    rule2 = { type = "ingress", from = 0, to = 0, protocol = "-1", self = true, desc = "Allow all traffic within SG - exa" }
  }

  tgw_db_routes = {
    default = {
      cidr   = "0.0.0.0/0"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }

  tgw_nlb_hscn_routes = {
    default = {
      cidr   = "0.0.0.0/0"
      tgw_id = "${local.tgw_id_hscn}"
    }
    onprem-10-139-0-0-16 = {
      cidr   = "10.139.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-10-141-0-0-16 = {
      cidr   = "10.141.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-44-0-0-0-8 = {
      cidr   = "44.0.0.0/8"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-100-64-0-0-10 = {
      cidr   = "100.64.0.0/10"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-172-16-0-0-16 = {
      cidr   = "172.16.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-192-168-0-0-16 = {
      cidr   = "192.168.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-195-11-196-45-32 = {
      cidr   = "195.11.196.45/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }
  tgw_other_routes = {
    default = {
      cidr   = "0.0.0.0/0"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }

  tgw_fsx_routes = {
    default = {
      cidr   = "0.0.0.0/0"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }

  tgw_wsus_routes = {
    default = {
      cidr   = "0.0.0.0/0"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }

  tgw_app_routes = {
    default = {
      cidr   = "0.0.0.0/0"
      tgw_id = "${local.tgw_id_hscn}"
    }
    dns_internal = {
      cidr   = "100.88.8.128/26"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-10-139-0-0-16 = {
      cidr   = "10.139.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-10-141-0-0-16 = {
      cidr   = "10.141.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-44-0-0-0-8 = {
      cidr   = "44.0.0.0/8"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-100-64-0-0-10 = {
      cidr   = "100.64.0.0/10"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-172-16-0-0-16 = {
      cidr   = "172.16.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-192-168-0-0-16 = {
      cidr   = "192.168.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-195-11-196-45-32 = {
      cidr   = "195.11.196.45/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-185-46-212-92-32 = {
      cidr   = "185.46.212.92/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-185-46-212-93-32 = {
      cidr   = "185.46.212.93/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-193-65-32 = {
      cidr   = "104.129.193.65/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-195-65-32 = {
      cidr   = "104.129.195.65/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-197-65-32 = {
      cidr   = "104.129.197.65/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-193-103-32 = {
      cidr   = "104.129.193.103/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-195-103-32 = {
      cidr   = "104.129.195.103/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-197-103-32 = {
      cidr   = "104.129.197.103/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    delinea-100-68-6-0-25 = {
      cidr   = "100.68.6.0/25"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }

  tgw_private_routes = {
    dns_internal = {
      cidr   = "100.88.8.128/26"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-10-139-0-0-16 = {
      cidr   = "10.139.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-10-141-0-0-16 = {
      cidr   = "10.141.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-44-0-0-0-8 = {
      cidr   = "44.0.0.0/8"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-100-64-0-0-10 = {
      cidr   = "100.64.0.0/10"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-172-16-0-0-16 = {
      cidr   = "172.16.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-192-168-0-0-16 = {
      cidr   = "192.168.0.0/16"
      tgw_id = "${local.tgw_id_backbone}"
    }
    onprem-195-11-196-45-32 = {
      cidr   = "195.11.196.45/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-185-46-212-92-32 = {
      cidr   = "185.46.212.92/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-185-46-212-93-32 = {
      cidr   = "185.46.212.93/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-193-65-32 = {
      cidr   = "104.129.193.65/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-195-65-32 = {
      cidr   = "104.129.195.65/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-197-65-32 = {
      cidr   = "104.129.197.65/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-193-103-32 = {
      cidr   = "104.129.193.103/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-195-103-32 = {
      cidr   = "104.129.195.103/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    zscaler-104-129-197-103-32 = {
      cidr   = "104.129.197.103/32"
      tgw_id = "${local.tgw_id_backbone}"
    }
    delinea-100-68-6-0-25 = {
      cidr   = "100.68.6.0/25"
      tgw_id = "${local.tgw_id_backbone}"
    }
  }

  peering_routes = {
    /*{nbu_peer = {
      vpc_cidr   = "${local.netbackup_cidr_block}"
      peering_id = "pcx-02dcd903e53ed8246"
    }*/
    england_peer = {
      vpc_cidr   = "100.68.32.0/23"
      peering_id = "pcx-0aacb6a8fb97a4cac"
    }
    nations_core_peer = {
      vpc_cidr   = "100.68.61.0/24"
      peering_id = "pcx-02efd697e49a1228b"
    }
    iom_peer = {
      vpc_cidr   = "100.68.62.0/26"
      peering_id = "pcx-07f7cea3917808d38"
    }
    exa_peer = {
      vpc_cidr = "100.68.55.192/26"
      peering_id = "pcx-07065dedffb14f309"
    }
  }

  wsus_peering_routes = {
    core_peer = {
      vpc_cidr   = "100.68.61.0/24"
      peering_id = "pcx-02efd697e49a1228b"
    }
    im_peer = {
      vpc_cidr   = "100.68.62.0/26"
      peering_id = "pcx-07f7cea3917808d38"
    }
  }

}
