ARGS                 = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS            += --silent

SHELL                = /bin/bash
HELP_SPACE           = 15

GIT_COMMIT_HASH      = $$(git rev-parse HEAD)
GIT_BRANCH           = $$(git rev-parse --abbrev-ref HEAD)
GIT_TAG              = $$(git describe --tags)

DOCKER_REGISTRY      = gismo
DOCKER_IMAGE         = ${DOCKER_REGISTRY}/docker-git-extras
DOCKER_PARAM_USER    =  -u `grep www-data /etc/passwd | cut -d: -f3`:`grep www-data /etc/group | cut -d: -f3`

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-$(HELP_SPACE)s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

install: ## build l'image necessaire au service fpm
	docker build --compress \
		--build-arg GIT_COMMIT_HASH=${GIT_COMMIT_HASH} \
		--build-arg GIT_BRANCH=${GIT_BRANCH} \
		--build-arg GIT_TAG=${GIT_TAG} \
		-t ${DOCKER_IMAGE} .

test:
	docker run --rm -t \
	-v $$(pwd):/app \
	${DOCKER_IMAGE}
