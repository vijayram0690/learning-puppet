class cms2 {

	exec { "download ffmpeg dependencies":
		command	=> "aws s3 cp  s3://cmaas.infrastructure/dependencies/ffmpeg/ffmpeg /usr/bin/ffmpeg --region=us-east-1",
		path	=> "/usr/bin/",
	}

	exec { "download media-check":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/cms2/cms2.war /usr/share/tomcat7/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=> Service["tomcat7"],
		require => Package["tomcat7"],
	}
}
