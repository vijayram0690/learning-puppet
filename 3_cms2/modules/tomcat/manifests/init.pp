class tomcat {

	package { "tomcat6":
		ensure	=> present,
	}

	package { "tomcat6-webapps":
		ensure	=> present,
		require	=> Package["tomcat6"],
	}

	service { "tomcat":
		ensure	=> "running",
		require => Package["tomcat6-webapps"],
	}
}
