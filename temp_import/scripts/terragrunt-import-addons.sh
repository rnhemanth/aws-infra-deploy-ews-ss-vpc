#!/usr/bin/env bash
TERRAGRUNT_CONFIG=$2
cd $1 && \
git config --global url."https://token:${GH_TOKEN}@github.com/emisgroup".insteadOf "https://github.com/emisgroup"
#terragrunt import 'aws_route.fsx_vpc_peering_route["nations_core_peer_1-rtb-0327ef7a51d5b0388"]' 'rtb-0327ef7a51d5b0388_100.88.132.0/22' --terragrunt-config $TERRAGRUNT_CONFIG
#terragrunt import 'aws_route.fsx_vpc_peering_route["nations_core_peer_2-rtb-0327ef7a51d5b0388"]' 'rtb-0327ef7a51d5b0388_100.88.136.0/22' --terragrunt-config $TERRAGRUNT_CONFIG
#terragrunt import 'aws_route53_resolver_rule_association.this["default_hscn"]' 'rslvr-rrassoc-54c6eafb6fac4ea4a' --terragrunt-config $TERRAGRUNT_CONFIG