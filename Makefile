# Read the Docs - Build container images

DOCKER ?= $(shell which docker)
IMAGES = zuul gerrit jenkins

.PHONY: images $(IMAGES) push

images: $(IMAGES)

push:
	docker push allanice001/zuul-stack:zuul
	docker push allanice001/zuul-stack:gerrit
	docker push allanice001/zuul-stack:jenkins

zuul: zuul/Dockerfile
	docker build -t allanice001/zuul-stack:zuul zuul/

gerrit: gerrit/Dockerfile
	docker build -t allanice001/zuul-stack:gerrit gerrit/

jenkins: jenkins/Dockerfile
	docker build -t allanice001/zuul-stack:jenkins gerrit/

all: zuul jenkins gerrit
