class profiles::base::bats_setup {
  # Install BATS test framework
  include integration_tests
  vcsrepo { '/home/vagrant/bats-framework':
    ensure   => latest,
    owner => "vagrant",
    group => "vagrant",
    provider => git,
    source   => 'https://github.com/sstephenson/bats.git',
    revision => 'master',
  }
  file { 'ensure_repo_is_owned_by_vagrant':
    ensure    => directory,
    recurse   => true,
    path      => "/home/vagrant",
    owner     => "vagrant",
  }
  exec { "install bats":
    cwd     => "/home/vagrant/bats-framework",
    creates => "/var/tmp/myfile",
    command => "sudo ./install.sh /usr/local",
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    user    => "vagrant",
    unless  => "which bats",
  }
  Vcsrepo [ '/home/vagrant/bats-framework' ] ~> File["ensure_repo_is_owned_by_vagrant"] ~>
Exec['install bats']
}