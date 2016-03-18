#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "should connect nginx test page at http://$(facter ipaddress_eth1)/" {
  result=$(curl --max-time 2 -sL -w "%{http_code}\\n" http://$(facter ipaddress_eth1)/ -o /dev/null)
  expected=200
  diff <(echo $result) <(echo $expected)
  [ $result = $expected ]
}