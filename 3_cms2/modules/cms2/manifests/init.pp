class cms2 {

	exec { "download ffmpeg dependencies":
		command	=> "aws s3 cp  s3://cmaas.infrastructure/dependencies/ffmpeg/ffmpeg /usr/bin/ffmpeg --region=us-east-1",
		path	=> "/usr/bin/",
	}

	file { "/usr/bin/ffmpeg":
		require	=> Exec["download ffmpeg dependencies"],
		mode	=> "755",
		notify  => Service["tomcat7"],
	}

	package { "ImageMagick":
		ensure	=> present,
		notify	=> Service["tomcat7"],
	}

	exec { "download cms2":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/cms2/cms2.war /usr/share/tomcat7/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=> Service["tomcat7"],
		require => Package["tomcat7"],
	}
}
