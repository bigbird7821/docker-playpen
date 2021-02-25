#!/usr/bin/env bats
#See https://github.com/sstephenson/bats

@test "sqlplus should successfully connect to oracle_xe container" {
  result=$(/usr/bin/expect <<- EOF
    spawn ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@localhost -p 2022
    expect "password: "
    send "admin\r"
    expect "# "
    send "uname -a\r"
    send "sqlplus /nolog\r"
    expect "SQL> "
    send "QUIT\r"
    expect "# "
    send "exit\r"
EOF
)
  expected1=$(echo "${result}" | grep -o "SQL\*Plus: Release 11.2.0.2.0 Production")
  diff <(echo "${expected1}") <(echo "SQL*Plus: Release 11.2.0.2.0 Production")
}