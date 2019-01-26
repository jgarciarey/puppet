# file: modules/mysql/manifests/init.pp
class mysql {     
    $packages_mysql = [
        "mysql-server",
        "python-mysqldb"
    ]

    # Instalación del servidor de MySQL
    package { $packages_mysql:
        ensure => present,
        require => Exec["apt-get update"]
    }
     
    # Arrancar el servicio de MySQL
    service { "mysql":
        ensure => running,
        require => Package["mysql-server"]
    }

    $db_name = "wp_db"
    $db_user = "wp_user"
    $db_password = "wp_pass"

    
    exec { "create-${db_name}-db":
    unless => "/usr/bin/mysql -uroot ${db_name}",
    command => "/usr/bin/mysql -uroot -e \"create database ${db_name};\"",
    require => Service["mysql"],
    }

    exec { "grant-${db_name}-db":
    unless => "/usr/bin/mysql -u${db_user} -p${db_password} ${db_name}",
    command => "/usr/bin/mysql -uroot -e \"grant all on ${db_name}.* to ${db_user}@localhost identified by '$db_password';\"",
    require => [Service["mysql"], Exec["create-${db_name}-db"]]
    }
    
}
