class newrelic::params {

  $package_name   = 'newrelic-sysmond'
  $package_ensure = 'present'
  $repo_manage    = true
  $service_name   = 'newrelic-sysmond'
  $service_ensure = 'running'
  $serivce_enable = true
  $service_manage = true
  $config_file    = '/etc/newrelic/nrsysmond.cfg'
  $log_file       = '/var/log/newrelic/nrsysmond.log'
  $log_level      = 'info'
  $proxy          = undef
  $use_ssl        = true
  $ssl_ca_bundle  = undef
  $ssl_ca_path    = undef
  $pid_file       = '/var/run/newrelic/nrsysmond.pid'
  $collector_host = undef
  $timeout        = undef

  case $::osfamily {
    'Debian': {
      $repo_type = 'apt::source'
      $repo_attributes = {
        newrelic => {
          location    => 'http://apt.newrelic.com/debian/',
          repos       => 'newrelic non-free',
          key         => '548C16BF',
          key_source  => 'http://download.newrelic.com/548C16BF.gpg',
          include_src => false,
          release     => ' ',
        }
      }
    }

    'RedHat': {
      $repo_type = 'yumrepo'
      $repo_attributes = {
        newrelic => {
          baseurl  => 'http://yum.newrelic.com/pub/newrelic/el5/$basearch',
          gpgkey   => 'http://yum.newrelic.com/548C16BF.gpg',
          descr    => 'New Relic packages for Enterprise Linux 5 - $basearch',
          enabled  => true,
          gpgcheck => true,
          target   => '/etc/yum.repos.d/newrelic.repo',
        }
      }
    }

    default: {
      fail("Error: ${::osfamily} is not yet supported in module ${module_name}")
    }
  }
}
