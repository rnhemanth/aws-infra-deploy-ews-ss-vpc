setup:
	chmod -R 777 ./scripts/
	@echo "- Installing Terragrunt..."
	./scripts/install-terragrunt.sh
	@echo "✔ Done"

terragrunt-plan:
	chmod -R 777 ./scripts/
	@echo "- Planning terraform..."
	./scripts/terragrunt-plan.sh ${terraform_folder} ${terragrunt_config}
	@echo "✔ Done"

terragrunt-apply:
	chmod -R 777 ./scripts/
	@echo "- Deploying terraform..."
	./scripts/terragrunt-apply.sh ${terraform_folder} ${terragrunt_config}
	@echo "✔ Done"

terragrunt-apply-addon:
	chmod -R 777 ./scripts/
	@echo "- Deploying terraform..."
	./scripts/terragrunt-apply-addons.sh
	@echo "✔ Done"

terragrunt-plan-addons:
	chmod -R 777 ./scripts/
	@echo "- Deploying terraform..."
	./scripts/terragrunt-plan-addons.sh
	@echo "✔ Done"

terragrunt-destroy:
	chmod -R 777 ./scripts/
	@echo "- Deploying terraform..."
	./scripts/terragrunt-destroy.sh ${terraform_folder} ${terragrunt_config}
	@echo "✔ Done"