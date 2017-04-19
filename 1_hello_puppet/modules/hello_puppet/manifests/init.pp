class hello_puppet {

	$www_dir = "/var/www"

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

	file { "${www_dir}/hello-puppet":
		ensure	=> directory,
		mode	=> 0644,
		require => Package["apache2"],
		notify	=> Service["apache2"],
	}

	file {"facts.txt":
			ensure	=> file,
			path		=> "${www_dir}/hello-puppet/facts.txt",
			content => "Hi Test This Learning Puppet VM's IP address is ${ipaddress}. It thinks its
hostname is ${fqdn}, but you might not be able to reach it there
from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
Puppet ${puppetversion}.",
		}
}
