FROM didricg/puppetbase
MAINTAINER Gavin Didrichsen "gavin.didricshen@gmail.com"

COPY ../puppet/modules/applications /etc/puppet/environments/example_env/modules
COPY ../puppet/manifests /etc/puppet/environments/example_env/manifests

WORKDIR /etc/puppet
RUN puppet module --verbose  install  puppetlabs-vcsrepo --target-dir /etc/puppet/modules 
RUN puppet module --verbose install puppetlabs-java --target-dir /etc/puppet/modules 
RUN puppet module --verbose install gini-gradle --target-dir /etc/puppet/modules 
RUN puppet module --verbose  install  huskycode-vim --target-dir /etc/puppet/modules
RUN  puppet apply --debug --verbose --modulepath=/etc/puppet/environments/example_env/modules/:/etc/puppet/modules/ -e "include roles::dev"
#CMD ["tail -f /dev/null"]
