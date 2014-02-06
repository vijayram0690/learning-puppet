class media_check {

	exec { "download mediainfo dependencies":
		command	=> "aws s3 cp  s3://cmaas.infrastructure/dependencies/mediainfo/ . --region=us-east-1 --recursive",
		path	=> "/usr/bin/",
	}

	exec { "install mediainfo packages":
		require	=> Exec["download mediainfo dependencies"],
		command	=> "yum -y install libzen0-0.4.29-1.x86_64.CentOS_6.rpm libmediainfo0-0.7.67-1.x86_64.CentOS_6.rpm mediainfo-0.7.67-1.x86_64.CentOS_6.rpm", 
		returns	=> [0,1], # 1 is acceptable if the package is already installed. TODO: improve this
		path	=> "/usr/bin/",
	}

	file { "/opt/mediainfo/":
		require	=> Exec["install mediainfo packages"],
		ensure	=> directory,
	}

	file { "/opt/mediainfo/mediainfo":
		ensure	=> link,
		target	=> '/usr/bin/mediainfo',
		notify 	=> Service["tomcat7"],
	}

	file { "media-check dir":
		ensure	=> directory,
		path	=> "/opt/mediacheck",
	}

	file { "media-check configuration":
		notify 	=> Service["tomcat7"],
		ensure	=> present,
		path	=> "/opt/mediacheck/config.properties",
		content => "mediacheck.db.address = 'mediacheck-db.dev-shared.cmaas.tv'
mediacheck.db.name = 'mcdb'
mediacheck.db.user = 'admin'
mediacheck.db.password = 'qu4l1ty*'",
	}

	exec { "download media-check":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/media-check/media-check.war /usr/share/tomcat7/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=> Service["tomcat7"],
		require => Package["tomcat7"],
	}
}
