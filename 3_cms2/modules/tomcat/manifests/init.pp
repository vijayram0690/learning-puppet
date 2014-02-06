class tomcat {

	package { "tomcat6":
		ensure	=> present,
                notify  => Service["tomcat6"],
	}

	# TODO: remove these packages
	package { "tomcat6-webapps":
		ensure	=> present,
		require	=> Package["tomcat6"],
                notify  => Service["tomcat6"],
	}

	package { "tomcat6-admin-webapps":
		ensure	=> present,
		require	=> Package["tomcat6"],
		notify	=> Service["tomcat6"],
	}

	service { "tomcat6":
		ensure	=> "running",
		require => Package["tomcat6-webapps"],
	}
}
