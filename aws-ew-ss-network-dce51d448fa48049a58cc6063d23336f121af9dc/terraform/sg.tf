## Security Group - Standard
module "security_group_standard" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-standard-ports"
  use_name_prefix         = false
  description             = "Security group with Standard ports"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.standard_sg_rules_cidr_blocks
  sg_rules_self           = var.standard_sg_rules_self
  sg_rules_security_group = var.standard_sg_rules_security_group
}

module "security_group_db_tier" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-db-tier"
  use_name_prefix         = false
  description             = "Security group for DB Tier"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.db_sg_rules_cidr_blocks
  sg_rules_self           = var.db_sg_rules_self
  sg_rules_security_group = var.db_sg_rules_security_group
}

module "security_group_backups" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-backups"
  use_name_prefix         = false
  description             = "Security group for Veritas Netbackup"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.backup_sg_rules_cidr_blocks
  sg_rules_self           = var.backup_sg_rules_self
  sg_rules_security_group = var.backup_sg_rules_security_group
}

## Security Group - APP Tier
module "security_group_app_tier" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-app-tier"
  use_name_prefix         = false
  description             = "Security group for App Tier"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.app_sg_rules_cidr_blocks
  sg_rules_self           = var.app_sg_rules_self
  sg_rules_security_group = var.app_sg_rules_security_group
}

## Security Group - EXA
module "security_group_exa" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-exa"
  use_name_prefix         = false
  description             = "Security group for EXA access"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.exa_sg_rules_cidr_blocks
  sg_rules_self           = var.exa_sg_rules_self
  sg_rules_security_group = var.exa_sg_rules_security_group
}

resource "aws_security_group_rule" "egress_db_web_app_egress" {
  type                     = "egress"
  from_port                = 1430
  to_port                  = 1440
  protocol                 = "TCP"
  source_security_group_id = module.security_group_db_tier.security_group_id
  security_group_id        = module.security_group_app_tier.security_group_id
  description              = "egress app traffic to database security group"
}

resource "aws_security_group_rule" "egress_tcp_db_app_egress" {
  type                     = "egress"
  from_port                = 49152
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = module.security_group_db_tier.security_group_id
  security_group_id        = module.security_group_app_tier.security_group_id
  description              = "egress SQL TCP traffic to database security group"
}

resource "aws_security_group_rule" "egress_udp_db_app_egress" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "UDP"
  source_security_group_id = module.security_group_db_tier.security_group_id
  security_group_id        = module.security_group_app_tier.security_group_id
  description              = "egress UDP traffic to database security group"
}


resource "aws_security_group_rule" "egress_db_web_app_ingress" {
  type                     = "ingress"
  from_port                = 1430
  to_port                  = 1440
  protocol                 = "TCP"
  source_security_group_id = module.security_group_app_tier.security_group_id
  security_group_id        = module.security_group_db_tier.security_group_id
  description              = "egress app traffic to database security group"
}

resource "aws_security_group_rule" "egress_tcp_db_app_ingress" {
  type                     = "ingress"
  from_port                = 49152
  to_port                  = 65535
  protocol                 = "TCP"
  source_security_group_id = module.security_group_app_tier.security_group_id
  security_group_id        = module.security_group_db_tier.security_group_id
  description              = "egress SQL TCP traffic to database security group"
}

resource "aws_security_group_rule" "egress_udp_db_app_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "UDP"
  source_security_group_id = module.security_group_app_tier.security_group_id
  security_group_id        = module.security_group_db_tier.security_group_id
  description              = "egress UDP traffic to database security group"
}

## Security Group - Firecracker
module "security_group_firecracker" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-firecracker"
  use_name_prefix         = false
  description             = "Security group to acess Firecracker"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.firecracker_sg_rules_cidr_blocks
  sg_rules_self           = var.firecracker_sg_rules_self
  sg_rules_security_group = var.firecracker_sg_rules_security_group
}

## Security Group - Legacy
module "security_group_legacy" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-legacy"
  use_name_prefix         = false
  description             = "Security group to access legacy"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.legacy_sg_rules_cidr_blocks
  sg_rules_self           = var.legacy_sg_rules_self
  sg_rules_security_group = var.legacy_sg_rules_security_group
}

## Security Group - OnPrem
module "security_group_onprem" {
  # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-on-prem"
  use_name_prefix         = false
  description             = "Security group to access onprem"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.onprem_sg_rules_cidr_blocks
  sg_rules_self           = var.onprem_sg_rules_self
  sg_rules_security_group = var.onprem_sg_rules_security_group
}

module "security_group_awspatchstores" {
   # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-sds-awspatchstores"
  use_name_prefix         = false
  description             = "Security group to access aws patch stores"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.awspatchstore_sg_rules_cidr_block
}

module "security_group_sds" {
   # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-sds"
  use_name_prefix         = false
  description             = "Security group to access sds"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.sds_sg_rules_cidr_block
}

module "security_group_private" {
     # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-private"
  use_name_prefix         = false
  description             = "Security group for private subnets"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.private_sg_rules_cidr_block
  sg_rules_self           = var.private_sg_rules_self
  sg_rules_security_group = var.private_sg_rules_security_group
}

module "security_group_oapi" {
         # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-oapi"
  use_name_prefix         = false
  description             = "Security group for private subnets"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.oapi_sg_rules_cidr_block
}

module "security_group_legacy_sds" {
        # checkov:skip=CKV_TF_1: "Ensure Terraform module sources use a commit hash"
  source                  = "git::https://github.com/emisgroup/terraform-aws-ec2-sg.git?ref=v0.1.0"
  name                    = "${var.tags.environment}-${var.tags.service}-net-sg-${var.tags.identifier}-legacy-sds"
  use_name_prefix         = false
  description             = "Security group for private subnets"
  vpc_id                  = module.vpc.vpc_id
  sg_rules_cidr_blocks    = var.legacy_sds_sg_rules_cidr_block
}