class profiles::docker::stm inherits profiles::docker::base::with_ssh {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test {"adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/docker/stm/",
  }

  # Implement the stm
  file { ['/vagrant/docker', '/vagrant/docker/stm']:
    ensure    => directory,
  }
  vcsrepo { '/vagrant/docker/stm':
    ensure   => latest,
    owner => "vagrant",
    group => "vagrant",
    provider => git,
    source   => 'https://github.com/TuxInvader/Docker-Brocade-vTM.git',
    revision => 'master',
  }
  Service['docker'] ~> File['/vagrant/docker', '/vagrant/docker/stm'] ~> Vcsrepo['/vagrant/docker/stm']
}
