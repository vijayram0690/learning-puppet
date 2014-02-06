class tomcat {

	exec { "set default region"
		command	=> "export AWS_DEFAULT_REGION=us-east-1",
		path	=> "/usr/bin",
	}

	exec { "download cms2":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/cms2/cms2.war /usr/share/tomcat6/webapps/",
		path	=> "/usr/bin",
		require	=>	Exec["set default region"],
		notify 	=>	Service["tomcat6"],
	}

	exec { "download media-check":
		command	=> "aws s3 cp s3://cmaas.dev.resources/war/media-check/media-check.war /usr/share/tomcat6/webapps/",
		path	=> "/usr/bin",
		require	=>	Exec["set default region"],
		notify 	=>	Service["tomcat6"],
	}
}
