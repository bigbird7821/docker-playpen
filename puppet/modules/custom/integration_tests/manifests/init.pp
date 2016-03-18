class integration_tests {
  file { "initialize-integration-script-permissions":
    path => "/vagrant/integration-test/integration.sh",
    ensure => present,
    mode => "0775",
  }
  
  exec { "initialize-integration-script":
    command => "cat <<- EOF >  /vagrant/integration-test/integration.sh
#!/bin/bash

# load useful functions
source /vagrant/scripts/bats/common-bats-functions.sh

# NOTE THIS FILE WILL BE AUTOMATICALLY UPDATED ON \"papply\"
 
EOF",
    unless => "grep \"NOTE THIS FILE\" /vagrant/integration-test/integration.sh",
    path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
    require => File["initialize-integration-script-permissions"],
  }
  define add_test ($source_dir, $dest_file_name="/vagrant/integration-test/integration.sh"){
	  exec{"$title":
	    command => "echo doBatTestInDirectory $source_dir >> $dest_file_name",
	    unless => "grep \"doBatTestInDirectory $source_dir\" $dest_file_name",
      path =>  [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
      require => Exec["initialize-integration-script"],
	  }
  }
}