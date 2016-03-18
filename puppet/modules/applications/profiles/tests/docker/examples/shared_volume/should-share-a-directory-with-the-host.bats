#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "docker 'shared-volume' container should be running" {
  result=$(docker ps | egrep -q "shared-volume" && echo "shared-volume docker container should be running")
  diff <(echo "${result}") <(echo "shared-volume docker container should be running")
}

@test "should successfully mount /vagrant/www (host) to the /tmp/www (container)" {
  skip "implement this"
}

@test "should successfully 'docker exec' to shared-volume" {
  result=$(/usr/bin/expect <<- EOF
    spawn sudo docker exec -i -t shared-volume bash
    expect "# "
    send "uname -a\r"
    expect "# "
    send "exit\r"
EOF
)
  expected1=$(echo "${result}" | egrep -q "3.13.0-77-generic #121-Ubuntu SMP" && echo "successfully ssh connection achieved")
  diff <(echo "${expected1}") <(echo "successfully ssh connection achieved")
}
