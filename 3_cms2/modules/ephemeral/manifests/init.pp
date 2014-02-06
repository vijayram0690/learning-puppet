class ephemeral {

	file { "/ephemeral":
		ensure	=> directory,
		mode	=> 0644,
	}

	mount { 'mount ephemeral':
		require	=> File["/ephemeral"],
		name	=> "/ephemeral",
		ensure	=> mounted,
		device	=> "/dev/xvdb",
		fstype	=> "ext3",
		notify	=> Service["httpd"]
	}
}
