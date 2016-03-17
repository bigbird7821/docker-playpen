FROM jamtur01/puppetbase
MAINTAINER James Turnbull "james@lovedthanlost.net"

WORKDIR /etc/puppet
RUN puppet module --verbose install puppetlabs-java --target-dir /etc/puppet/modules
RUN puppet module --verbose install rtyler-jenkins --target-dir /etc/puppet/modules
RUN puppet module --verbose install dhoppe-vim --target-dir /etc/puppet/modules
RUN puppet apply --modulepath=/etc/puppet/modules -e "class {'vim': }"
RUN puppet apply --modulepath=/etc/puppet/modules -e "class {'jenkins': }"
EXPOSE 8080
CMD ["jenkins"]
