#!/usr/bin/env bash
TERRAGRUNT_CONFIG=$2
cd $1 && \
terragrunt destroy -compact-warnings -auto-approve --terragrunt-config $TERRAGRUNT_CONFIG --terragrunt-non-interactive
