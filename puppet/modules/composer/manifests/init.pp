class composer {

	case $composer_installed {
		yes: {
			exec { 'update_composer':
			  command     => "/usr/bin/composer self-update"
			}
		}
		no: {
			package { 'curl': 
		  		ensure  => present,
			}
			
			exec { 'download_composer':
			  command     => '/usr/bin/curl -s http://getcomposer.org/installer | php',
			  cwd         => '/tmp',
			  creates     => "/tmp/composer.phar",
			  require => Package['curl','php5-cli']
			}

			file { "/usr/bin/composer":
			  ensure      => present,
			  source      => "/tmp/composer.phar",
			  mode        => '0755',
			  require => Exec['download_composer']
			}

			exec { 'update_composer':
			  command     => "/usr/bin/composer self-update",
			  require => File['/usr/bin/composer']
			}
		}
	}

}