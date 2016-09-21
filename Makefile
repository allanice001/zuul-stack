# Read the Docs - Build container images

DOCKER ?= $(shell which docker)
IMAGES = zuul gerrit jenkins gitlab-ce

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

gitlab-ce: gitlab-ce/Dockerfile
	docker build -t allanice001/zuulstack:gitlab-ce gitlab-ce/

all: zuul jenkins gerrit gitlab-ce
