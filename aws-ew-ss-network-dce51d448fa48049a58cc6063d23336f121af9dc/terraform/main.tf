# VPC
module "vpc" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source = "git::https://github.com/emisgroup/terraform-aws-vpc.git?ref=v0.3.1"

  ipv4_primary_cidr_block              = var.ipv4_primary_cidr_block
  ipv4_secondary_cidr_blocks           = var.ipv4_secondary_cidr_blocks
  manage_default_security_group        = true
  manage_default_route_table           = true
  manage_default_network_acl           = true
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  create_dhcp_options                  = true
  create_igw                           = true
  create_nat_gateway                   = true
  create_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60
  intra_subnets                        = var.intra_subnets
  public_subnets                       = var.public_subnets
  private_subnets                      = var.private_subnets
  #tags                                 = var.tags
  name                                 = var.name
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_log_cloudwatch_log_group_retention_in_days
}

# VPC Endpoints
module "vpc_endpoints" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source = "git::https://github.com/emisgroup/terraform-aws-vpc-endpoints.git?ref=v0.0.1"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [aws_security_group.vpce_tls.id]

 endpoints = merge({
    s3 = {
      service            = "s3"
      subnet_ids         = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids = [aws_security_group.vpce_tls.id]
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    },
    secretsmanager = {
      service             = "secretsmanager"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    },
    smtp = {
      service             = "email-smtp"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    }
  }, var.tags.environment == "prd" ? {
    sms = {
      service             = "pinpoint-sms-voice-v2"
      private_dns_enabled = true
      policy              = data.aws_iam_policy_document.sms_endpoint_policy.json
      subnet_ids          = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
      security_group_ids  = [aws_security_group.vpce_tls.id]
    }
  } : {})
  tags = var.tags
}

data "aws_subnet" "vpce_2a" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  tags = {
    Name = "${var.tags.environment}-${var.tags.service}-net-sub-tgw-vpce-2a"
  }
  depends_on = [
    module.vpc
  ]
}

data "aws_subnet" "vpce_2b" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  tags = {
    Name = "${var.tags.environment}-${var.tags.service}-net-sub-tgw-vpce-2b"
  }
  depends_on = [
    module.vpc
  ]
}

data "aws_subnet" "vpce_2c" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  tags = {
    Name = "${var.tags.environment}-${var.tags.service}-net-sub-tgw-vpce-2c"
  }
  depends_on = [
    module.vpc
  ]
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["dynamodb:*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:sourceVpce"

      values = [module.vpc.vpc_id]
    }
  }
}

data "aws_iam_policy_document" "sms_endpoint_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sms-voice:SendTextMessage"]
    resources = ["arn:aws:sms-voice:eu-west-2:${data.aws_caller_identity.current.account_id}:sender-id/EmisWeb/GB",
                 "arn:aws:sms-voice:eu-west-2:${data.aws_caller_identity.current.account_id}:sender-id/EMISWEB/GB"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/EMEUW2ECGEN-EC2-Role"]
    }
  }
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

resource "aws_security_group" "vpce_tls" {
  # checkov:skip=CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC for VPC Endpoints"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  ingress {
    description = "Secure mail from VPC for VPC Endpoints"
    from_port   = 587
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
    }

  tags = {
    "Name" = "${var.tags.environment}-${var.tags.service}-net-sg-vpce-${var.tags.identifier}"
  }
}

module "transit_gateway_attachment" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source = "git::https://github.com/emisgroup/terraform-aws-tgw-attach.git?ref=v0.0.1"
  transit_gateway_attachments = {
    prd-tgw-backbone = {
      vpc_id             = module.vpc.vpc_id
      transit_gateway_id = var.tgw_id_backbone
      subnet_ids         = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
    },
    prd-tgw-hscn = {
      vpc_id             = module.vpc.vpc_id
      transit_gateway_id = var.tgw_id_hscn
      subnet_ids         = [data.aws_subnet.vpce_2a.id, data.aws_subnet.vpce_2b.id, data.aws_subnet.vpce_2c.id]
    },
    
  }
  tags = var.tags
}


data "aws_vpc_endpoint" "s3" {
  vpc_id       = module.vpc.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  tags = {
    Name = "${var.tags.environment}-${var.tags.service}-net-vpce-${var.tags.identifier}-s3"

  }
  depends_on = [
    module.vpc_endpoints
  ]
}

resource "aws_route53_zone" "this" {
  # checkov:skip=CKV2_AWS_38: "Ensure Domain Name System Security Extensions (DNSSEC) signing is enabled for Amazon Route 53 public hosted zones - Skipping private hosted zone"
  # checkov:skip=CKV2_AWS_39: ""Ensure Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones - Skipping private hosted zone"
  name = "s3.${data.aws_region.current.name}.amazonaws.com"
  vpc {
    vpc_id = module.vpc.vpc_id
  }
}

resource "aws_route53_record" "this" {
  zone_id = aws_route53_zone.this.id
  name    = ""
  type    = "A"

  alias {
    name                   = replace(data.aws_vpc_endpoint.s3.dns_entry[0].dns_name, "*", "\\052")
    zone_id                = data.aws_vpc_endpoint.s3.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }
}

# This specific resource is for the PHZs that need one extra alias with a "*" (for example, Amazon S3)
resource "aws_route53_record" "this_wildcard" {
  zone_id = aws_route53_zone.this.id
  name    = "*"
  type    = "A"

  alias {
    name                   = replace(data.aws_vpc_endpoint.s3.dns_entry[0].dns_name, "*", "\\052")
    zone_id                = data.aws_vpc_endpoint.s3.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }
}

module "vpc_peering" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source = "git::https://github.com/emisgroup/terraform-aws-vpc-peering.git?ref=v0.2.0"
  vpc_peering_connections = {
    vpc-england = {
      vpc_id        = module.vpc.vpc_id
      peer_vpc_id   = var.peer_vpc_id
      peer_owner_id = var.peer_owner_id
      peer_region   = var.peer_region
    }
  }
      tags = var.tags
      name = "${var.tags.environment}-ewss-net-vpc-peer-${var.tags.identifier}"
}