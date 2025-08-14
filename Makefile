bootstrap-england-dev:
	@echo "- Bootstrap England dev environment..."
	./aws-ew-ss-network/bootstrap/setup bootstrap dev ewss england eu-west-2 aws-infra-deploy-ews-ss-vpc core-infra
	@echo "✔ Done"

bootstrap-england-stg:
	@echo "- Bootstrap England stg environment..."
	./aws-ew-ss-network/bootstrap/setup bootstrap stg ewss england eu-west-2 aws-infra-deploy-ews-ss-vpc core-infra
	@echo "✔ Done"

bootstrap-england-prd:
	@echo "- Bootstrap england prd environment..."
	./aws-ew-ss-network/bootstrap/setup bootstrap prd ewss england eu-west-2 aws-infra-deploy-ews-ss-vpc core-infra
	@echo "✔ Done"

destory-role-england-dev:
	@echo "- Destroying github-deploy-core-infra role in England dev environment..."
	./aws-ew-ss-network/bootstrap/setup bootstrap dev ewss england eu-west-2 aws-infra-deploy-ews-ss-vpc core-infra destroy
	@echo "✔ Done"

destory-role-england-stg:
	@echo "- Destroying github-deploy-core-infra role in England stg environment..."
	./aws-ew-ss-network/bootstrap/setup bootstrap stg ewss england eu-west-2 aws-infra-deploy-ews-ss-vpc core-infra destroy
	@echo "✔ Done"

destory-role-england-prd:
	@echo "- Destroying github-deploy-core-infra role in England prd environment..."
	./aws-ew-ss-network/bootstrap/setup bootstrap prd ewss england eu-west-2 aws-infra-deploy-ews-ss-vpc core-infra destroy
	@echo "✔ Done"