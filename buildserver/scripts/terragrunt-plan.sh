#!/usr/bin/env bash
set -e
TERRAGRUNT_CONFIG=$2
cd $1 && \
git config --global url."https://token:${GH_TOKEN}@github.com/emisgroup".insteadOf "https://github.com/emisgroup"
terragrunt plan -compact-warnings --terragrunt-forward-tf-stdout -out plan.out --terragrunt-config $TERRAGRUNT_CONFIG --terragrunt-non-interactive && terraform show -no-color plan.out > ../../plan.out
sed -i '1s/^/\`\`\`/' ../../plan.out
echo "\`\`\`" >> ../../plan.out
