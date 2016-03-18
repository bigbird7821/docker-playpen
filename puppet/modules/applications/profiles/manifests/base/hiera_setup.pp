class profiles::base::hiera_setup {
  # Add symbolic link to allow debugging of hiera on the command-line
  file { '/etc/hiera.yaml':
    ensure  => link,
    target  => "/vagrant/hiera.yaml",
  }
}