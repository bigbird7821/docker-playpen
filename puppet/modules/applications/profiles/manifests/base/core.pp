class profiles::base::core {
  #require profiles::base::hiera_setup
  #require profiles::base::bats_setup
  #require profiles::base::forge_setup

  # automatically add this module's tests into a common integration test suite
  #integration_tests::add_test {"adding-integration-tests-for-${name}" :
    #source_dir => "/vagrant/puppet/modules/applications/profiles/tests/base/core/",
  #}

  # install expect
  package { 'expect':
    ensure  => installed,
  }

  # install dos2unix
  package { 'dos2unix':
    ensure  => installed,
  }

  # Install vim with some extra plugins
  class { "vim":
    user => "root",
    home_dir => "/root",
  }
  vim::plugin { "nerdtree":
    source => 'https://github.com/scrooloose/nerdtree.git',
  }
  vim::plugin { "vim-surround":
    source => 'https://github.com/tpope/vim-surround.git',
  }

}
