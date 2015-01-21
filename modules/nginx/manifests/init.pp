# simple module to install nginx
class nginx {

	package { "nginx":
		ensure => installed,
		provider => yum;
	}

	file {
		[ "/var/www/",
		"/var/www/nwea",
		]:
			ensure => directory;

		"/etc/nginx/conf.d/nwea.conf":
			ensure  => present,
			source  => "puppet:///modules/nginx/nwea.conf",
			mode    => 0644,
			owner   => root,
			group   => root,
			require => Package["nginx"];

		"/var/www/nwea/index.html":
			source  => "puppet:///modules/nginx/index.html",
			mode    => 0644,
			notify  => Service["nginx"],
			require => File["/var/www/nwea"];
	}

	service {
		"nginx":
			ensure  => running,
			require => Package["nginx"];
	}
}

# vim: ts=2 sw=2 filetype=puppet
