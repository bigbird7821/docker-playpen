class profiles::base::forge_setup {

  # Install upstart script that copies /etc/puppet/modules directory to /vagrant/etc/puppet--only do it every 20 secs
  include 'upstart'
  file { ["/vagrant/etc", "/vagrant/etc/puppet"]:
    ensure    => directory,
    owner     => "vagrant",
    group     => "vagrant",
  }
  upstart::job { 'rsync_puppet_modules':
    description    => 'This is an example upstart service',
    version        => '3626f2',
    respawn        => true,
    respawn_limit  => '5 10',
    user           => 'vagrant',
    group          => 'vagrant',
    chdir          => '/vagrant/etc/puppet',
    script         => "
      sudo rsync -avz --ignore-existing --exclude '.git/' --delete /etc/puppet/modules /vagrant/etc/puppet
      sleep 20
    ",
  }
  File ["/vagrant/etc", "/vagrant/etc/puppet"] ~> Upstart::Job['rsync_puppet_modules']

}