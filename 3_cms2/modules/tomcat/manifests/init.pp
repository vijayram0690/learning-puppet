class tomcat {

	package { "tomcat7":
		ensure	=> present,
	}

	service { "tomcat7":
		ensure	=> "running",
		require => Package["tomcat7"],
	}
}
