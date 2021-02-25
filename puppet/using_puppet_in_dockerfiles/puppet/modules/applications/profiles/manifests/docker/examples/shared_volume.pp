class profiles::docker::examples::shared_volume inherits profiles::docker::base::with_ssh {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test { "adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/docker/examples/shared_volume/",
  }

  docker::run { 'shared-volume':
    image   => 'profiles_docker_base_with_ssh',
    volumes => ['/vagrant/www:/tmp/www'],
    ports           => [ '22' ],
    expose          => [ '22' ],
    detach          => true,
    extra_parameters => ['--restart=always'],
    command           => "/usr/sbin/sshd -D",
  }
  Service['docker'] ~> Docker::Image['profiles_docker_base_with_ssh'] ~> Docker::Run['shared-volume']

}
