class newrelic::service inherits newrelic {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_manage == true {
    service { 'newrelic':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => File['config_file'],
    }
  }
}
