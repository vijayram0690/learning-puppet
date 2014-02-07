class tomcat {

	package { "java-1.7.0-openjdk.x86_64":
		ensure	=> present,
	}

	package { "tomcat7":
		ensure	=> present,
	}

	service { "tomcat7":
		ensure	=> "running",
		require => Package["tomcat7"],
	}
}
