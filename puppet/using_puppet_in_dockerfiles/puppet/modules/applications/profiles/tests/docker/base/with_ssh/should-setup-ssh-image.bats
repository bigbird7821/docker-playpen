#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "profiles_docker_base_with_ssh docker image should be present" {
  result=$(docker images | egrep -q "profiles_docker_base_with_ssh" && echo "profiles_docker_base_with_ssh docker image is present")
  diff <(echo "${result}") <(echo "profiles_docker_base_with_ssh docker image is present")
}

