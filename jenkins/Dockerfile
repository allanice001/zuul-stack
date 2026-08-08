FROM ubuntu:24.04@sha256:561618e2c15bf2397621dd04f96926663a3b5616c189cf7e38db7e82f5c538ea
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
  python3-setuptools git jenkins python-pip python-dev
# RUN apt-get -y install gearman-job-server libgearman-dev php-pear php5-dev
# RUN pecl install gearman

RUN git clone https://github.com/openstack-infra/zuul.git /opt/zuul
RUN pip install pytz
RUN pip install /opt/zuul

EXPOSE 8080
CMD ["/bin/bash"]
