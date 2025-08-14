setup:
	@echo "- Installing Terragrunt..."
	./scripts/install-terragrunt.sh
	@echo "✔ Done"

terragrunt-import:
	@echo "- Deploying terraform..."
	./scripts/terragrunt-import.sh ${terraform_folder} ${terragrunt_config}
	@echo "✔ Done"

terragrunt-import-addons:
	@echo "- Deploying terraform..."
	./scripts/terragrunt-import-addons.sh ${terraform_folder} ${terragrunt_config}
	@echo "✔ Done"