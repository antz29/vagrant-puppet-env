include apt

/* Setup Sources */

exec { 'apt-get update': 
    command => '/usr/bin/apt-get update'
}

exec { 'apt-get dist-upgrade': 
    command => '/usr/bin/apt-get -y dist-upgrade',
    require => Exec['apt-get update']
}

/* Install Nginx */
class { 'nginx':
  require => Exec['apt-get dist-upgrade']
}

/* Install PHP */
class { 'phpfpm': 
  require => Exec['apt-get dist-upgrade'] 
}

/* Install MongoDB */
class { 'mongodb': 
  require => Exec['apt-get dist-upgrade'] 
}

/* Install Composer */
class { 'composer': 
  require => Exec['apt-get dist-upgrade'] 
}
