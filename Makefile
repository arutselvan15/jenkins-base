APPNAME=jenkins-ci
UIPORT=8080
APIPORT=50000
WORKSPACE=$(shell pwd)/ci-workspace
USER=jenkins
DOCKER_REPO=arutselvan15/${APPNAME}
BUILD=$(or ${BUILD_NUMBER},0)
VERSION=v0.1.${BUILD}
DATE=$(shell date)
HOST=$(shell hostname)

## display this help message
help:
	@echo ''
	@echo 'make targets for the project:'
	@echo
	@echo 'Usage:'
	@echo '  ## Develop / Test Commands ##'
	@echo '  clean           Run clean up.'
	@echo '  ### git hub ###'
	@echo '  push            Run push to push changes to git.'
	@echo '  ### docker hub ###'
	@echo '  docker-build    Run docker-build to build the docker image.'
	@echo '  docker-run      Run docker-run on run the app in docker container.'
	@echo '  docker-push     Run docker-push on push the app in docker hug.'
	@echo '  ## setup (requires sudo ) ##'
	@echo '  setup           Run setup to create local setup'

clean:
	@echo "==> Cleaning..."

push:
	@echo "==> Git Push..."
	git push

docker-build:
	@echo "==> Build Docker Image..."
	echo "Version=${VERSION} Date=${DATE} BuildNode=${HOST}" > version.txt
	docker build -t ${DOCKER_REPO}:${VERSION} .

docker-run:
	@echo "==> Docker Run..."
	docker run -p ${UIPORT}:${UIPORT} -p ${APIPORT}:${APIPORT} -v ${WORKSPACE}:/var/jenkins_home ${DOCKER_REPO}:${VERSION}

docker-push:
	@echo "==> Docker Push..."
	docker push ${DOCKER_REPO}:${VERSION}

setup:
	@echo "==> Adding jenkins user..."
	sudo adduser ${USER} || echo "${USER} User already exists."

	@echo "==> Setting workspace permission..."
	sudo chown jenkins:jenkins ${WORKSPACE}
	sudo chmod 0777 ${WORKSPACE}
