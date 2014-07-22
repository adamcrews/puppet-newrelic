class newrelic::install inherits newrelic {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $repo_manage {
    $defaults = {
      before => Package['newrelic'],
    }
    create_resources($repo_type, $repo_attributes, $defaults)
  }

  package { 'newrelic':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
