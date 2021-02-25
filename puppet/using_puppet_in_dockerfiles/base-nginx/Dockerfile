FROM jamtur01/puppetbase
MAINTAINER James Turnbull "james@lovedthanlost.net"

WORKDIR /etc/puppet
RUN puppet module --verbose install jfryman-nginx --target-dir /etc/puppet/modules
RUN puppet apply --modulepath=/etc/puppet/modules -e "class { 'nginx': }"
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx"]
