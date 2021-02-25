#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "docker 'container-with-ssh' container should be running" {
  result=$(docker ps | egrep -q "container-with-ssh" && echo "container-with-ssh docker container should be running")
  diff <(echo "${result}") <(echo "container-with-ssh docker container should be running")
}

@test "should successfully 'docker exec' to container-with-ssh" {

  result=$(/usr/bin/expect <<- EOF
    spawn sudo docker exec -i -t container-with-ssh bash
    expect "# "
    send "uname -a\r"
    expect "# "
    send "exit\r"
EOF
)
  expected1=$(echo "${result}" | egrep -q "3.13.0-77-generic #121-Ubuntu SMP" && echo "successfully ssh connection achieved")
  diff <(echo "${expected1}") <(echo "successfully ssh connection achieved")
}
