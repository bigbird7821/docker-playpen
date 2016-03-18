class profiles::docker::oracle_xe inherits profiles::docker::base::core {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test { "adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/docker/oracle_xe/",
  }

  /*
  See https://hub.docker.com/r/wnameless/oracle-xe-11g/
  To connect to the database:
    hostname: localhost
    port: 49161
    sid: xe
    uhsername: system
    password: oracle

  To SSH to the container:
    ssh localhost -p 2022 (on either VM or host)
  */
  docker::run { 'oracle_xe':
    image           => 'wnameless/oracle-xe-11g',
    ports           => ['2022:22', '2521:1521'],
    expose          => ['22', '1521'],
    env             => ['FOO=BAR', 'FOO2=BAR2'],
    before_stop     => 'echo "So Long, and Thanks for All the Fish"',
  }
  Service['docker'] ~> Docker::Run['oracle_xe']

}
