class profiles::docker::base::core inherits profiles::base::core {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test { "adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/docker/base/core/",
  }

  # install docker
  if $::http_proxy == undef {
    notice("setting proxy to undef")
    $proxy = undef
  } else {
    notice("setting proxy to $::http_proxy")
    $proxy = $::http_proxy
  }
  if $::no_proxy == undef {
    notice("setting no_proxy to undef")
    $noProxy = undef
  } else {
    notice("setting no_proxy to $::no_proxy")
    $noProxy = $::no_proxy
  }
  class { 'docker':
    version     => 'latest',
    tcp_bind    => 'tcp://127.0.0.1:4243',
    socket_bind => 'unix:///var/run/docker.sock',
    proxy       => $proxy,
    no_proxy    => $noProxy,
    #no_proxy    => 'localhost,127.0.0.1,.bt.com',
  }

  # Modify the vagrant user to include the 'docker' group
  $myusers = {
    'vagrant' => { groups => ['docker', ], }
  }
  class { 'system::users':
    config   => $myusers,
    schedule => 'daily',
    real     => true,
  }

  Class['docker'] ~> Class['system::users']

}
