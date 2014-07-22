class newrelic::config inherits newrelic {

  $log_dir = dirname($log_file)
  $real_ssl = $use_ssl ? {
    false   => 'false',
    default => 'true',
  }

  File {
    require => Package['newrelic'],
    notify  => Service['newrelic'],
  }

  File_line { 
    ensure  => present,
    path    => $config_file,
    require => File['config_file'],
    notify  => Service['newrelic'],
  }

  # The file is supplied by the package, let's just enforce
  # permissions and make sure we can modify it with augeas
  file { 'config_file':
    ensure => file,
    path   => $config_file,
    owner  => 'newrelic',
    group  => 'newrelic',
    mode   => '0640',
  }

  file_line { 'set newrelic license':
    match  => 'license_key=',
    line   => "license_key=${license}"
  }

  file_line { 'set newrelic log_file':
    match  => 'logfile=',
    line   => "logfile=${log_file}",
  }

  file_line { 'set newrelic pid_file':
    match  => 'pidfile='
    line   => "pidfile=${pid_file}",
  }

  file_line { 'set newrelic ssl':
    match  => 'ssl='
    line   => "ssl=${real_ssl}",
  }

  if $proxy {
    file_line { 'Set newrelic proxy':
      match  => 'proxy=',
      line   => "proxy=${proxy}",
    }
  }

  if $ssl_ca_bundle { 
    file_line { 'Set newrelic ssl_ca_bundle':
      match  => 'ssl_ca_bundle='
      line   => "ssl_ca_bundle=${ssl_ca_bundle}",
    }
  }

  if $ssl_ca_path { 
    file_line { 'Set newrelic ssl_ca_path':
      match  => 'ssl_ca_path=',
      line   => "ssl_ca_path=${ssl_ca_path}",
    }
  }

  if $log_level {
    file_line { 'Set newrelic loglevel':
      match  => 'loglevel=',
      line   => "loglevel=${log_level}",
    }
  }

  if $collector_host { 
    file_line { 'Set newrelic collector host':
      match  => 'collector_host='
      line   => "collector_host=${collector_host}",
    }
  }

  if $timeout { 
    file_line { 'Set newrelic timeout':
      match  => 'timeout=',
      line   => "timeout=${timeout}",
    }
  }

  file { $log_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { $log_file:
    ensure => file,
    owner  => 'newrelic',
    group  => 'newrelic',
    mode   => '0644',
  }
}
