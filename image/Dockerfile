FROM ubuntu:14.04
MAINTAINER James Turnbull "james@lovedthanlost.net"

WORKDIR /tmp
RUN apt-get -y update
RUN apt-get install -y wget
RUN wget http://apt.puppetlabs.com/puppetlabs-release-trusty.deb
RUN dpkg -i /tmp/puppetlabs-release-trusty.deb
RUN apt-get -y update
RUN apt-get install -y puppet git-core
