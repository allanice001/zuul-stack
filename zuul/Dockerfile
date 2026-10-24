FROM ubuntu:26.04@sha256:c098726dd9b9733f3e885f8de0ef375206a311b0a317eadc40d347b1115fb944
MAINTAINER AcmeAWS <support@acmeaws.com>

ENV DEBIAN_FRONTEND noninteractive
ENV APPDIR /opt
ENV LANG C.UTF-8
USER root

RUN apt-get -y update
RUN apt-get install wget -y
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# RUN add-apt-repository ppa:gearman-developers/ppa

RUN apt-get -y update
RUN apt-get -y install vim software-properties-common python-setuptools \
  python3-setuptools git python-pip python-dev
# RUN apt-get -y install gearman-job-server libgearman-dev php-pear php5-dev
# RUN pecl install gearman

RUN git clone https://github.com/openstack-infra/zuul.git /opt/zuul
RUN pip install pytz
RUN pip install /opt/zuul

CMD ["/bin/bash"]
