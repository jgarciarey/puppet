# file: modules/wordpress/manifests/init.pp
class wordpress {     
    $packages_wp = [
        "unzip",
    ]

    package { $packages_wp:
        ensure => present,
        require => Exec["apt-get update"]
    }

    $install_dir = '/var/www/'

    file { "${install_dir}":
        ensure  => directory,
        recurse => true,
    }

    file { "/tmp/wordpress.zip":
        source => 'puppet:///modules/wordpress/wordpress.zip',
    }

    exec { 'Extract wordpress':
        command => "/usr/bin/unzip /tmp/wordpress.zip -d ${install_dir}",
        require => Package["unzip"]
    }

    $dir_wordpress = '/var/www/wordpress'

    file { '/var/www/wordpress/wp-config.php':
        ensure  => file,
        content => template('wordpress/wp-config-sample.php'),
    }
}
