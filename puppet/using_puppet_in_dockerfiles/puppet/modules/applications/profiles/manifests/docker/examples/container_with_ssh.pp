class profiles::docker::examples::container_with_ssh inherits profiles::docker::base::with_ssh {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test { "adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/docker/examples/container_with_ssh/",
  }

  # NOTE:  This creates a Service["$docker::run::service_prefix-container-with-ssh"]
  # and the extra_parameters => ['--restart=always'] ensures that this service is
  # started
  docker::run { 'container-with-ssh':
    image           => 'profiles_docker_base_with_ssh',
    ports           => [ '22' ],
    expose          => [ '22' ],
    detach          => true,
    extra_parameters => ['--restart=always'],
    command           => "/usr/sbin/sshd -D",
  }
  Service['docker'] ~> Docker::Image['profiles_docker_base_with_ssh'] ~> Docker::Run['container-with-ssh']

}
