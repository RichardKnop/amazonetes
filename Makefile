.PHONY: all

TERRAFORM_CMD = terraform $(1) \
	-state=${DEPLOY_ENV}.tfstate \
	${ARGS}

all:
	$(error Usage: make <plan|apply|destroy> DEPLOY_ENV=name [ARGS=extra_args])

check-env-aws: check-env-var
ifndef AWS_SECRET_ACCESS_KEY
	$(error Environment variable AWS_SECRET_ACCESS_KEY must be set)
endif
ifndef AWS_ACCESS_KEY_ID
	$(error Environment variable AWS_ACCESS_KEY_ID must be set)
endif

check-env-var:
ifndef DEPLOY_ENV
	$(error Must pass DEPLOY_ENV=<name>)
endif

plan: check-env-var check-env-aws
	TF_VAR_env=${DEPLOY_ENV} $(call TERRAFORM_CMD,plan)

apply: check-env-var check-env-aws
	TF_VAR_env=${DEPLOY_ENV} $(call TERRAFORM_CMD,apply)

destroy: check-env-var check-env-aws
	TF_VAR_env=${DEPLOY_ENV} $(call TERRAFORM_CMD,destroy)
