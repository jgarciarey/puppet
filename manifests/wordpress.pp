$install_dir = '/var/www/wordpress.unir.com'

file { "${install_dir}":
	ensure  => directory,
	recurse => true,
}

file { "${install_dir}/wp-config-sample.php":
	ensure => present,
}

exec { 'Download wordpress':
	command => "wget http://wordpress.org/latest.tar.gz -O /tmp/wp.tar.gz",
	creates => "/tmp/wp.tar.gz",
	require => [ File["${install_dir}"], Package["wget"] ],
} ->
exec { 'Extract wordpress':
	command => "sudo tar zxvf /tmp/wp.tar.gz --strip-components=1 -C ${install_dir}",
	creates => "${install_dir}/index.php",
	require => Exec["Download wordpress"],
} ->
exec { "copy_def_config":
	command => "/usr/bin/cp ${install_dir}/wp-config-sample.php ${install_dir}/wp-config.php",
	creates => "${install_dir}/wp-config.php",
	require => File["${install_dir}/wp-config-sample.php"],
} ->
file_line { 'db_name_line':
  path  => "${install_dir}/wp-config.php",
  line  => "define('DB_NAME', 'wordpress_db');",
  match => "^define\\('DB_NAME*",
} ->
file_line { 'db_user_line':
  path  => "${install_dir}/wp-config.php",
  line  => "define('DB_USER', 'wordpress_user');",
  match => "^define\\('DB_USER*",
} ->
file_line { 'db_password_line':
  path  => "${install_dir}/wp-config.php",
  line  => "define('DB_PASSWORD', 'wordpress');",
  match => "^define\\('DB_PASSWORD*",
} ->
file_line { 'db_host_line':
  path  => "${install_dir}/wp-config.php",
  line  => "define('DB_HOST', '192.168.33.3');",
  match => "^define\\('DB_HOST*",
} ~>
