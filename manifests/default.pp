 package { "epel-release-6-8.noarch":
 	provider => "rpm",
 	ensure => installed,
 	source => "http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
 }

$nfsutils = [ "nfs-utils" ]
package {$nfsutils:
 	ensure => installed,
}

$phpbase = [ "httpd", "php-pecl-apc", "php-mysql", "mysql-server", "php-cli", "php-gd", "php", "php-mbstring", "php-xml", "php-intl" ]

package {$phpbase:
 	ensure => installed,
 	notify => Service['httpd'],
}

$phpextra = [ "php-mcrypt", "php-pecl-xdebug", "phpMyAdmin"]
package { $phpextra:
	ensure => installed,
	require => Package["epel-release-6-8.noarch"],
	notify => Service['httpd'],
}

service { "httpd":
	ensure => running,
	require => Package["httpd"],
	enable => true,
}

service { "mysqld":
	ensure => running,
	require => Package["mysql-server"],
	enable => true,
}

service { "rpcbind":
	ensure => running,
	require => Package["nfs-utils"],
	enable => true,
}

service { "iptables":
	ensure => stopped,
	enable => false,
}

file { "/etc/httpd/conf.d/00-vhost.conf":
	source => "/vagrant/etc/00-vhost.conf",
	notify => Service['httpd'],
	require => Package["httpd"],
	replace => false,
}

file { "/etc/httpd/conf.d/phpMyAdmin.conf":
	source => "/vagrant/etc/phpMyAdmin.conf",
	notify => Service['httpd'],
	require => Package["httpd"],
}

file { "/etc/php.d/zz_local.ini":
	source => "/vagrant/etc/php_local.ini",
	notify => Service['httpd'],
	require => Package["php"],
}

file { "/etc/phpMyAdmin/config.inc.php":
	source => "/vagrant/etc/config.inc.php",
	require => Package["phpMyAdmin"],
}

exec { "pmadb":
	command => '/usr/bin/mysql -u root < /usr/share/phpMyAdmin/examples/create_tables.sql',
	creates => '/var/lib/mysql/phpmyadmin',
	require => [ Service["mysqld"], Package["phpMyAdmin"] ],
}

yumrepo { "google_pagespeed":
    descr       => "Google Pagespeed",
    baseurl     => "http://dl.google.com/linux/mod-pagespeed/rpm/stable/x86_64",
    enabled     => 1,
    gpgcheck    => 0,
    name        => "mod-pagespeed",
    includepkgs => "mod-pagespeed-stable",
}

package { "mod-pagespeed-stable":
    ensure  => present,
    require => [ Yumrepo["google_pagespeed"], Package["httpd"] ],
    notify  => Service["httpd"],
}
