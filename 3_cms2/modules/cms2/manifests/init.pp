class cms2 {

/*
	exec { "download cms2":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/cms2/cms2.war /usr/share/tomcat6/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=> Service["tomcat6"],
		require	=> Package["tomcat6"],
	}
*/

	exec { "install mediainfo":
		command	=> "\
aws s3 cp  s3://cmaas.infrastructure/dependencies/mediainfo/ . --region=us-east-1 --recursive	\
yum -y install libzen0-0.4.29-1.x86_64.CentOS_6.rpm",
		path	=> "/usr/bin/"

	}

	file { "media-check dir":
		ensure	=> directory,
		path	=> "/opt/mediacheck",
	}

	file { "media-check configuration":
		notify	=> Exec["download media-check"],
		ensure	=> present,
		path	=> "/opt/mediacheck/config.properties",
		content => "mediacheck.db.address = 'mediacheck-db.dev-shared.cmaas.tv'
mediacheck.db.name = 'mcdb'
mediacheck.db.user = 'admin'
mediacheck.db.password = 'qu4l1ty*'",
	}

	exec { "download media-check":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/media-check/media-check.war /usr/share/tomcat6/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=> Service["tomcat6"],
                require => Package["tomcat6"],
	}
}
