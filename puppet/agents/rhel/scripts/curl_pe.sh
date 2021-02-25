#!/bin/bash
set -eu

get_csv_of_policies(){
   openssl ciphers -v | perl -pe 's/[ \t]+/,/g' 2>/dev/null | sort
}

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

create_debug_of_cipher_lists(){

    if is_rhel8; then 
        # ensure results directory is present
        mkdir -p results

        # set DEFAULT policy and get the sorted list of ciphers
        update-crypto-policies --set DEFAULT 2>/dev/null
        get_csv_of_policies > ./results/rhel8_default_ciphers.csv

        # set FUTURE policy and get the sorted list of ciphers
        update-crypto-policies --set FUTURE 2>/dev/null
        get_csv_of_policies > ./results/rhel8_future_ciphers.csv

        # create csv of ciphers common to both--this should probably be equal to the FUTURE set as it is a narrower set than DEFAULT
        comm -12 ./results/rhel8_default_ciphers.csv ./results/rhel8_future_ciphers.csv > ./results/rhel8_common_to_both_ciphers.csv
    else
        get_csv_of_policies > ./results/rhel7_ciphers.csv
    fi
}

#######################################################################
#                               MAIN                                  #
#######################################################################
host_pe=''
DEBUG=''
while getopts ":dh:" arg; do
  case $arg in
    d)
      DEBUG='true'
      ;;
    h)
      host_pe=$OPTARG
      ;;
  esac
done

echo ">> Assessing cipher connection to https://${host_pe}:8140 from $(cat /etc/redhat-release)"

# bomb out if invalid host:port
if ! nc -zv ${host_pe} 8140; then echo "${host_pe}:8140 is not valid" && exit 1; fi

if [[ "${DEBUG}" == "true" ]]; then create_debug_of_cipher_lists; fi

if is_rhel8; then 
    # set FUTURE policy and get the sorted list of ciphers
    update-crypto-policies --set FUTURE 2>/dev/null

    # Find a FUTURE cipher that works against the RHEL7 Puppet Enterprise endpoint
    future_ciphers=($(get_csv_of_policies))
    for cipher_row in  "${future_ciphers[@]}"; do 
        cipher=$(echo "${cipher_row}" | cut -f1 -d",")
        command="curl -s -k -I -vv --ciphers ${cipher} https://${host_pe}:8140/packages/current/install.bash"
        echo ">> Curling with ${cipher_row}"
        echo "${command}"
        if eval "${command}"; then
            echo "...SUCCEEDED."
        else
            echo "...FAILED."
        fi
    done
else 
    protocols=("--tlsv1.1" "--tlsv1.2" "--tlsv1.3") 
    for protocol in  "${protocols[@]}"; do 
        command="curl -s -k -I -vv -1 ${protocol} https://${host_pe}:8140/packages/current/install.bash"
        echo ">> Curling with ${protocol}"
        echo "${command}"
        if eval "${command}"; then
            echo "...SUCCEEDED."
        else
            echo "...FAILED."
        fi
    done
fi