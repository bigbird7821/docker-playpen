#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "vagrant user should be in 'docker' group (daemon won't start without this)" {
  result=$(groups)
  diff <(echo "${result}") <(echo "vagrant docker")
}

@test "docker daemon should be running" {
  result=$(docker ps | egrep -o "CONTAINER ID")
  diff <(echo "${result}") <(echo "CONTAINER ID")
}

@test "docker service should be running" {
  result=$(sudo service docker status | egrep -o "docker start/running, process" )
  diff <(echo "${result}") <(echo "docker start/running, process")
}

