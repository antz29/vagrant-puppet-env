class nginx {
	package { 'nginx':
  		ensure => installed,
  		before => File[ "/etc/nginx/sites-available/default" ]
	}

	file { "/etc/nginx/sites-available/default": 
	  ensure      	=> present,
	  source      => "puppet:///modules/nginx/default.conf",
	  group       	=> 'root',
	  mode        	=> '0644'
	}

	service { 'nginx':
	    ensure 		=> running,
	    require 	=> [ Package['nginx'] ],
	    subscribe  	=> File['/etc/nginx/sites-available/default']
	}
}