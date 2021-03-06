# Customise the following variable as Make parameters
# to produce a yum.repo for a VENDOR distribution
# Default values are pointing to GerritForge (www.gerritforge.com)
VERSION=2.12.4
RELEASE=1
VENDOR=GerritForge
VENDOR_LC=$(shell echo $(VENDOR) | tr A-Z a-z)
IMAGE=$(VENDOR_LC)/gerrit-ubuntu15.04
PGP_KEY_ID=1871F775
NO_CACHE=true
# End of the variables that can be customized
define DOCKERFILE
FROM ubuntu:15.04
MAINTAINER $(VENDOR)
# Add Gerrit packages repository
RUN echo "deb mirror://mirrorlist.$(VENDOR_LC).com/deb gerrit contrib" > /etc/apt/sources.list.d/$(VENDOR).list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys $(PGP_KEY_ID)
# Allow remote connectivity and sudo
RUN apt-get update
RUN apt-key update
RUN apt-get -y install openssh-client sudo
# Install OpenJDK and Gerrit in two subsequent transactions
# (pre-trans Gerrit script needs to have access to the Java command)
RUN apt-get -y install openjdk-7-jdk
RUN apt-get -y install gerrit=$(VERSION)-$(RELEASE)
USER gerrit
RUN java -jar /var/gerrit/bin/gerrit.war init --batch -d /var/gerrit
RUN java -jar /var/gerrit/bin/gerrit.war reindex -d /var/gerrit
# Allow incoming traffic
EXPOSE 29418 8080
# Start Gerrit
CMD /var/gerrit/bin/gerrit.sh start && tail -f /var/gerrit/logs/error_log
endef
export DOCKERFILE
image: prepare
	echo "$$DOCKERFILE" > Dockerfile
	docker build --no-cache=$(NO_CACHE) -t $(IMAGE):$(VERSION) .
clean:
	-rm -Rf docker_files
	-rm Dockerfile
prepare:
	echo "$$DOCKERFILE" > Dockerfile
	-mkdir -p docker_files
run: image
	docker run -d -p 8080:8080 -p 29418:29418 $(IMAGE):$(VERSION)
.PHONY: clean prepare image
