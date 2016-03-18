class profiles::www inherits profiles::base::core {

  # automatically add this module's tests into a common integration test suite
  integration_tests::add_test {"adding-integration-tests-for-${name}" :
    source_dir => "/vagrant/puppet/modules/applications/profiles/tests/www/",
  }

  class { 'nginx': }
  nginx::resource::vhost { 'www.test.com':
    www_root => '/vagrant/www',
  }

}