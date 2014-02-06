class cms2 {

	exec { "download cms2":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/cms2/cms2.war /usr/share/tomcat6/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=>	Service["tomcat6"],
	}

	exec { "download media-check":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/media-check/media-check.war /usr/share/tomcat6/webapps/ --region us-east-1",
		path	=> "/usr/bin",
		notify 	=>	Service["tomcat6"],
	}
}
