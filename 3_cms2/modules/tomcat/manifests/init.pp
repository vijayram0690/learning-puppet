class tomcat {

        package { "java-1.7.0-openjdk.x86_64":
                ensure  => present,
                notify  => Service["tomcat7"],
        }

        package { "java-1.6.0-openjdk.x86_64":
                require => Package["tomcat7"],
                ensure  => absent,
                notify  => Service["tomcat7"],
        }

        package { "tomcat7":
                ensure  => present,
        }

        service { "tomcat7":
                ensure  => "running",
                require => Package["tomcat7"],
        }
}

