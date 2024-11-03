{
	services.grafana = {
		enable = true;
		dataDir = "/var/lib/grafana";
		settings = {
			server = {
				http_addr = "127.0.0.1";
				http_port = 3000;
				serve_from_sub_path = true;
			};
		};
	};
}
