#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "rsync_puppet_modules upstart should be running" {
  result=$(sudo service rsync_puppet_modules status | egrep -o "rsync_puppet_modules start/running, process")
  expected="rsync_puppet_modules start/running, process"
  diff <(echo "${result}") <(echo "${expected}")
}

@test "rsync_puppet_modules upstart should have successfully copied /etc/puppet/modules/apt" {
  result=$(ls -1 /vagrant/etc/puppet/modules | egrep -o "apt")
  diff <(echo "${result}") <(echo "apt")
}