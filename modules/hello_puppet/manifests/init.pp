class hello_puppet {

	exec { "apt-get update":
		path => "/usr/bin",
	}

	package { "apache2":
		ensure	=> present,
		require => Exec["apt-get update"],
	}

	service { "apache2":
		ensure	=> "running",
		require => Package["apache2"],
	}

	file { "/var/www/hello-puppet":
		ensure	=> directory,
		mode	=> 0644,
		require => Package["apache2"],
		notify	=> Service["apache2"],
	}

	file {'facts.txt':
			ensure	=> file,
			path		=> '/var/www/hello-puppet/facts.txt',
			content => "This Learning Puppet VM's IP address is ${ipaddress}. It thinks its
hostname is ${fqdn}, but you might not be able to reach it there
from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
Puppet ${puppetversion}.",
		}
}
