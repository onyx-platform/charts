VERSION=4
PROJECT_ID=zookeeper
PROJECT=997690819742.dkr.ecr.us-east-1.amazonaws.com/${PROJECT_ID}

all: build

build:
	docker build --pull -t ${PROJECT}:${VERSION} .

push: build
	docker tag ${PROJECT}:${VERSION} ${PROJECT}:latest
	docker push ${PROJECT}:${VERSION}
	docker push ${PROJECT}:latest

.PHONY: all build push
