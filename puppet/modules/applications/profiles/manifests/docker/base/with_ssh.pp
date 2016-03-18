class profiles::docker::base::with_ssh inherits profiles::docker::base::core  {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test { "adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/docker/base/with_ssh/",
  }

  # install docker
  if $::http_proxy == undef {
    notice("::http_proxy is undef")
    $httpProxy = ""
    $httpsProxy = ""
  } else {
    notice("::http_proxy is undef")
    $httpProxy = "ENV http_proxy $::http_proxy"
    $httpsProxy = "ENV https_proxy $::http_proxy"
  }
  file { '/tmp/Dockerfile':
    ensure => file,
    content => template("profiles/docker/base/dockerfile_with_ssh.erb"),
  }
  docker::image { 'profiles_docker_base_with_ssh':
    docker_file => '/tmp/Dockerfile',
  }

  # ensure that profiles::base::facter_setup already in place, since it sets up $::http_proxy, which is used by
  # the Docker::Image
  Class['docker'] ~> File['/tmp/Dockerfile'] ~> Docker::Image['profiles_docker_base_with_ssh']
  #Class['profiles::base::facter_setup'] ~> Class['docker'] ~> File['/tmp/Dockerfile'] ~> Docker::Image['profiles_docker_base_with_ssh']

}
