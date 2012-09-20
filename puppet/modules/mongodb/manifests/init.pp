class mongodb {

	apt::source { '10gen':
	  location    => 'http://downloads-distro.mongodb.org/repo/ubuntu-upstart',
	  release     => 'dist',
	  repos       => '10gen',
	  key         => '7F0CEB10',
	  key_server  => 'keyserver.ubuntu.com',
	  include_src => false,
	}

	exec { 'updateapt': 
	    command => '/usr/bin/apt-get update',
	    require => Apt::Source['10gen']
	}

	package { 'mongodb-10gen':
	  require => Exec['updateapt'],
	  ensure => installed,
	  before => File["/etc/mongodb.conf"]
	}

	package { 'mongo':
	  ensure => installed,
	  require => [ Class['pecl'], Package['php5-fpm'] ],
	  provider => 'pecl',
	  notify => Service['php5-fpm']
	}

	file { "/etc/mongodb.conf": 
	  ensure      => present,
	  source      => "puppet:///modules/mongodb/mongodb.conf",
	  group       => 'root',
	  mode        => '0755'
	}

	service { 'mongodb':
	    ensure     => running,
	    require    => Package['mongodb-10gen'],
	    subscribe	=> File["/etc/mongodb.conf"]
	}

}