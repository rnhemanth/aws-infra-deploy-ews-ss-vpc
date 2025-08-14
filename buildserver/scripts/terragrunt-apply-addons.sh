#!/usr/bin/env bash
TERRAGRUNT_CONFIG="terragrunt.hcl"
cd ../aws-ew-ss-network/terraform/addons && \
git config --global url."https://token:${GH_TOKEN}@github.com/emisgroup".insteadOf "https://github.com/emisgroup"
terragrunt plan --terragrunt-forward-tf-stdout --terragrunt-config $TERRAGRUNT_CONFIG --terragrunt-non-interactive
