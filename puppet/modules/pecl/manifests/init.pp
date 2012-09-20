class pecl {
	
	package { 'php-pear':
	  ensure => installed,
	  require => Package['php5-cli','php5-fpm']
	}

	package { 'php5-dev':
	  ensure => installed,
	  require => Package['php5-cli','php5-fpm']
	}	

}