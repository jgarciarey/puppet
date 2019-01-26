# file: modules/apache/manifests/init.pp
class apache {
    # Actualizar los repositorios de paquetes
    exec { "apt-get update":
        command => "/usr/bin/apt-get update"
    }
     
    # Instalación de Apache
    package { "apache2":
        ensure => present,
        require => Exec["apt-get update"]
    }
     
    # Arrancar el servicio de Apache
    service { "apache2":
        ensure => running,
        require => Package["apache2"]
    }

    # Lista de paquetes de PHP para instalar
    $packages_php = [
        "php5-mysql",
        "php5",
        "libapache2-mod-php5",
        "php5-mcrypt"
    ]

    # Instalación de los paquetes de PHP
    package { $packages_php:
        ensure => present,
        require => Exec["apt-get update"],
    }

    file { '/etc/apache2/sites-enabled/000-default.conf':
        ensure  => file,
        content => template('apache/000-default.conf'),
        require => Exec["apt-get update"],
        notify => Service["apache2"]
    }
}
