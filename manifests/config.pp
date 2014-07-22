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

  Augeas { 
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

  augeas { 'Set newrelic options':
    context => "/files/${config_file}",
    changes => [
      "set license_key ${license}",
      "set logfile ${log_file}",
      "set pidfile ${pid_file}",
      "set ssl ${real_ssl}",
    ],
  }

  if $proxy {
    augeas { 'Set newrelic proxy':
      context => "/files/${config_file}",
      changes => "set proxy ${proxy}",
    }
  }

  if $ssl_ca_bundle { 
    augeas { 'Set newrelic ssl_ca_bundle':
      context => "/files/${config_file}",
      changes => "set ssl_ca_bundle ${ssl_ca_bundle}",
    }
  }

  if $ssl_ca_path { 
    augeas { 'Set newrelic ssl_ca_path':
      context => "/files/${config_file}",
      changes => "set ssl_ca_path ${ssl_ca_path}",
    }
  }

  if $log_level {
    augeas { 'Set newrelic loglevel':
      context => "/files/${config_file}",
      changes => "set loglevel ${log_level}",
    }
  }

  if $collector_host { 
    augeas { 'Set newrelic collector host':
      context => "/files/${config_file}",
      changes => "set collector_host ${collector_host}",
    }
  }

  if $timeout { 
    augeas { 'Set newrelic timeout':
      context => "/files/${config_file}",
      changes => "set timeout ${timeout}",
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
