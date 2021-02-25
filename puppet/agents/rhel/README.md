# rhel

This project was created to test SSL connectivity to various puppet enterprise hosts (centos 7, centos 8, pe 201819, pe 201984) under specific TLS conditions.  For example the following questions were posed:

* Can I curl to a centos 7 PE (any version) from a RHEL 8 agent using DEFAULT cipher settings?  What about FUTURE cipher settings?
* If PE is installed on centos 8 and the cipher settings are restricted to FUTURE, will I be able to connect from a RHEL 7 node?  What about a RHEL 8 node?
* If my RHEL 8 node is configured to only allow FUTURE cipher communications, will it be able to communicate with a centos 7 PE without the same?

So to answer these and other questions, 3 PE instances were setup on Platform9 (centos 7 with 201819, centos 7 with 201984, and centos 8 with 201984) and agent nodes (rhel7 and rhel8) were created in docker.  The included scripts were used to test curl connection from the rhel7 and rhel8 nodes to the various PE instances 

## Pre-Requisites

Before doing anything, verify you have access to the RedHat docker registry [the Red Hat Ecosystem Catalog](https://catalog.redhat.com/software/containers/search).  Without this access, you won't be able to pull the required Red Hat docker images.  If you don't have access, then follow the online instructions to create an account, generate an authorization token, etc.  On first creation of the account, you will need to log into the registry using the token.  After that, nothing more needs to be done; docker pull/build/run should work as expected.

Update the "extra_hosts" section in the docker-compose.yaml file to contain correct HOST <==> IP ADDRESS mappings between PE instances.

## Usage

docker-compose up --build -t
From each of the running containers, cd to the /root/app/scripts directory which is the bind mount of PWD.
Run a curl test connect using the ``curl_pe.sh`` script.  See the ``run.sh`` for example usage.  The ``list.sh`` is an example script that I used to build a ruby array of all the ciphers.

Note, you can also use openssl to verify connections to the PE servers and get things like the public certificate, e.g.,


```bash
openssl s_client -connect pe-201984-m-8.platform9.puppet.net:8140 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'
```
