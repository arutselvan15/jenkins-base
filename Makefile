PROJECT_NAME=jenkins-base

UI_PORT=8080
API_PORT=50000

BUILD=$(or ${BUILD_NUMBER},3)
VERSION=v0.1.${BUILD}
DATE=$(shell date)
HOSTNAME=$(shell hostname)

DOCKER_HUB=arutselvan15

## display this help message
help:
	@echo ''
	@echo 'make targets for the project:'
	@echo
	@echo 'Usage:'
	@echo '  ## Develop / Test Commands ##'
	@echo '  clean           Run clean up.'
	@echo '  ### git hub ###'
	@echo '  build            Run build to execute build steps.'
	@echo '  ### docker hub ###'
	@echo '  docker-build    Run docker-build to build the docker image.'
	@echo '  docker-run      Run docker-run on run the app in docker container.'
	@echo '  docker-push     Run docker-push on push the app in docker hug.'
	@echo '  ## setup (requires sudo ) ##'
	@echo '  setup           Run setup to create local setup'

clean:
	@echo "==> Cleaning..."

build:
	@echo "==> Build ..."
	echo "Version=${VERSION}" > version.txt
	echo "Date=${DATE}" >> version.txt
	echo "Host=${HOSTNAME}" >> version.txt
	cat version.txt

docker-build:
	@echo "==> Build Docker Image..."
	docker build -t ${DOCKER_HUB}/${PROJECT_NAME}:${VERSION} .

docker-run:
	@echo "==> Docker Run..."
	docker run -p ${UI_PORT}:${UI_PORT} -p ${API_PORT}:${API_PORT} ${DOCKER_HUB}/${PROJECT_NAME}:${VERSION}

docker-push:
	@echo "==> Docker Push..."
	docker push ${DOCKER_HUB}/${PROJECT_NAME}:${VERSION}

