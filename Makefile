LAST_COMMIT = $(shell git rev-parse HEAD)

ANSIBLE=ansible-playbook \
		--connection=local \
		--vault-password-file /app/vault-secret

.PHONY: help
help: ## This help message
	@awk -F: \
		'/^([a-z-]+): *.* ## (.+)$$/ {gsub(/: .*?\s*##/, "\t");print}' \
		Makefile \
	| expand -t20 \
	| sort

##############################################################################

.PHONY: dev-prepare
dev-prepare: ## Set pre-commit configuration
	pre-commit install

.PHONY: namespace
namespace: ## Creates a namespace and a user
	${ANSIBLE} ./provisionning-project/provisioning-openshift.yml \
		-i ${INVENTORY} \
		-e ORGANIZATION_NAME=${ORGANIZATION_NAME} \
		-e PROJECT_NAME=${PROJECT_NAME} \
		-e K8S_PERMISSION_LEVEL=${K8S_PERMISSION_LEVEL} \
		-e EMAIL=${EMAIL} \
		-e ${ENV_LIST}

.PHONY: backoffice
backoffice: ## Creates the backoffite resources of the console
	${ANSIBLE} ./provisionning-project/provisioning-project-dso.yml \
		-i ${INVENTORY} \
		-e REPO_NAME=${REPO_NAME} \
		-e ORGANIZATION_NAME=${ORGANIZATION_NAME} \
		-e EMAIL=${EMAIL} \
		-e PROJECT_NAME=${PROJECT_NAME} \
		-e ${ENV_LIST}
