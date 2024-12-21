{ config, pkgs, ... }:

{
	home.packages = ( with pkgs; [
		python312Packages.psycopg2	
	]);
}
