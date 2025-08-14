#!/usr/bin/env bash
TERRAGRUNT_CONFIG=$2
cd $1 && \
git config --global url."https://token:${GH_TOKEN}@github.com/emisgroup".insteadOf "https://github.com/emisgroup"
#terragrunt import 'module.security_group_app_tier[0].aws_security_group_rule.cidr_blocks["rule19"]' 'sg-0c6b55c119bb757fd_ingress_tcp_80_80_192.168.0.0/16' --terragrunt-config $TERRAGRUNT_CONFIG