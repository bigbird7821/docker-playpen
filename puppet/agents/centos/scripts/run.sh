#!/bin/bash

is_rhel8() {
    local redhat_release=$(cat /etc/redhat-release)
    # if [[ "Red Hat Enterprise Linux release 8" =~ "${redhat_release}" ]]; then
    if [[ "${redhat_release}" =~ "Red Hat Enterprise Linux release 8" ]]; then
        echo "RHEL8 [${redhat_release}]" 1>&2
        return 0
    else
        echo "RHEL7 [${redhat_release}]" 1>&2
        return 1
    fi
}

if is_rhel8; then 
    ./curl_pe.sh -d -h pe-201819-m-7.platform9.puppet.net | tee results/rhel8_to_2018_centos7.log
    ./curl_pe.sh -h pe-201984-m-7.platform9.puppet.net | tee results/rhel8_to_201984pe_centos7.log
    # ./curl_pe.sh -h pe-201984-m-8.platform9.puppet.net | tee results/rhel8_to_201984pe_centos8.log
    ./curl_pe.sh -h pe-201984-m-8.platform9.puppet.net | tee results/rhel8_to_201984pe_centos8_FUTURE.log
else
    ./curl_pe.sh -d -h pe-201819-m-7.platform9.puppet.net | tee results/rhel7_to_2018_centos7.log
    ./curl_pe.sh -h pe-201984-m-7.platform9.puppet.net | tee results/rhel7_to_201984pe_centos7.log
    # ./curl_pe.sh -h pe-201984-m-8.platform9.puppet.net | tee results/rhel7_to_201984pe_centos8.log
    ./curl_pe.sh -h pe-201984-m-8.platform9.puppet.net | tee results/rhel7_to_201984pe_centos8_FUTURE.log
fi