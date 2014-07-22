# == Class: newrelic
#
# This class installs and configures NewRelic server monitoring.
#
# === Parameters
#
# [*package_name*]
#   The name of the newrelic package
#
# [*service_name*]
#   The name of the newrelic service
#
# === Variables
#
# === Examples
#
# === Authors
#
# Adam Crews <adam.crews@gmail.com>
#
# === Copyright
#
# Copyright 2014 Adam Crews, unless otherwise noted.
#
# https://github.com/fsalum/puppet-newrelic and 
# https://github.com/adamcrews/puppet-nessus 
# were heavily used as references for implementing 
# this module.
#
class newrelic ( 

  $license,
  $package_name     = $newrelic::params::package_name,
  $package_ensure   = $newrelic::params::package_ensure,
  $repo_manage      = $newrelic::params::repo_manage,
  $service_name     = $newrelic::params::service_name,
  $service_ensure   = $newrelic::params::service_ensure,
  $service_enable   = $newrelic::params::service_enable,
  $service_manage   = $newrelic::params::service_manage,
  $repo_type        = $newrelic::params::repo_type,
  $repo_attributes  = $newrelic::params::repo_attributes,
  $config_file      = $newrelic::params::config_file,
  $log_file         = $newrelic::params::log_file,
  $log_level        = $newrelic::params::log_level,
  $proxy            = $newrelic::params::proxy,
  $use_ssl          = $newrelic::params::use_ssl,
  $ssl_ca_bundle    = $newrelic::params::ssl_ca_bundle,
  $ssl_ca_path      = $newrelic::params::ssl_ca_path,
  $pid_file         = $newrelic::params::pid_file,
  $collector_host   = $newrelic::params::collector_host,
  $timeout          = $newrelic::params::timeout,

) inherits newrelic::params {

  validate_string($license)
  validate_string($package_name)
  validate_string($package_ensure)
  validate_bool($repo_manage)
  validate_string($service_name)
  validate_re($service_ensure, [ '^running', '^stopped' ], '$service_ensure must be running or stopped')
  validate_bool($service_manage)
  validate_string($repo_type)
  validate_hash($repo_attributes)
  validate_absolute_path($config_file)
  validate_absolute_path($log_file)
  validate_re($log_level, [ '^error', '^warning', '^info', '^verbose', '^debug', '^verbosedebug' ], '$log_level must be either error, warning, info, verbose, debug, or verbosedebug')
  validate_bool($use_ssl)
  validate_absolute_path($pid_file)

  if $proxy {
    validate_string($proxy)
  }

  if $ssl_ca_bundle {
    validate_absolute_path($ssl_ca_bundle)
  }

  if $ssl_ca_path {
    validate_absolute_path($ssl_ca_path)
  }

  if $collector_host {
    validate_string($collector_host)
  }

  if $timeout {
    validate_string($timeout)
  }

  anchor { 'newrelic::begin': } ->
    class { 'newrelic::install': } ->
    class { 'newrelic::config': } ->
    class { 'newrelic::service': } ->
  anchor { 'newrelic::end': }

}
