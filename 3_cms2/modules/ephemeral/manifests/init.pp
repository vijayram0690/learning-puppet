class ephemeral {

	file { "/ephemeral":
		ensure	=> "link",
		target	=> "/media/ephemeral0",
	}
}
