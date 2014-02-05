class hello_puppet {

	$www_dir = "/var/www/html"

	package { "httpd":
		ensure	=> present,
	}

	service { "httpd":
		ensure	=> "running",
		require => Package["httpd"],
	}

	file { "${www_dir}/hello-puppet":
		ensure	=> directory,
		mode	=> 0644,
		require => Package["httpd"],
		notify	=> Service["httpd"],
	}

	file { "/ephemeral":
		ensure	=> directory,
		mode	=> 0644,
	}

	mount { 'mount ephemeral':
		requires	=> File["/ephemeral"],
		name		=> "/ephemeral",
		ensure		=> mounted,
		device		=> "/dev/xvdb",
		fstype		=> "ext3",
		notify		=> Service["httpd"]
	}

	file {"facts.txt":
			ensure	=> file,
			path		=> "${www_dir}/hello-puppet/facts.txt",
			content => "This Learning Puppet VM's IP address is ${ipaddress}. It thinks its
hostname is ${fqdn}, but you might not be able to reach it there
from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
Puppet ${puppetversion}.",
		}
}
