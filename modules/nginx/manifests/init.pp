# simple module to install nginx
class nginx {

  package { "nginx":
    ensure => installed,
    require => File["/etc/yum.repos.d/nginx.repo"],
    provider => yum;
  }

  file {
    [ "/var/www/",
    "/var/www/nwea",
    ]:
      ensure => directory;

    "/etc/nginx/conf.d/default.conf":
      ensure => absent,
      notify => Service["nginx"],
      require => Package["nginx"];

    "/etc/nginx/conf.d/nwea.conf":
      ensure  => present,
      source  => "puppet:///modules/nginx/nwea.conf",
      mode    => 0644,
      owner   => root,
      group   => root,
      require => Package["nginx"];

    "/etc/yum.repos.d/nginx.repo":
      owner => root,
      group => root,
      mode  => 0644,
      content => template('nginx/nginx.erb');
  }

  vcsrepo { '/var/www/nwea':
    ensure => present,
    provider => git,
    source => 'https://github.com/nwea-techops/tech_quiz.git',
    revision => master;
  }

  service {
    "nginx":
      ensure  => running,
      require => Package["nginx"];
  }
}

# vim: ts=2 sw=2 filetype=puppet
