#newrelic

[![Build Status](https://travis-ci.org/adamcrews/puppet-newrelic.svg)](https://travis-ci.org/adamcrews/puppet-newrelic)

####Table of Contents

1. [Overview](#overview)
2. [Setup - The basics](#setup)
3. [Usage - Configuration options and examples](#usage)
4. [Reference - Class, parameter, and fact documentation](#reference)
5. [Limitations](#limitations)
6. [ToDo](#todo)
7. [Contributors](#contributors)

##Overview

The nessus module installs, configures, and manages the newrelic system monitor daemon.

##Setup

The default class requires a license key to be entered.  Either set this key in hiera, or call the class with the license class parameter.

```puppet
class { '::newrelic':
  license => 'XXXX-XXXX-XXXX-XXXX'
}
```

##Usage

All interaction with the newrelic module can be done through the main nessus class.
You can simply toggle the optios in `::newrelic` to have complete functionality.

##Reference

###Classes

####Public Classes

* newrelic: Main class, includes all other classes.

####Private Classes

* newrelic::install: Handles installing the package.
* newrelic::config: License and configure newrelic.
* newrelic::service: Handles the service.

###Parameters

The following parameters are available in the newrelic module:

####`license`

The license code from your newrelic account.

####`package_name`

The name of the newrelic package being installed, defaults to 'newrelic-sysmond'.

####`package_ensure`

Determines what to do with the package, valid options are present/installed, latest, or absent.

####`service_name`

The service name for newrelic.

####`service_ensure`

Determines the state of the service, valid options are running or stopped.

####`service_manage`

Selects wether puppet should manage the service.

####`repo_manage`

Selects wether puppet should install the newrelic package repo.

####`repo_type`

The type of repo to install (yumrepo, apt::source).

####`repo_attributes`

The parameters required for setting up the repo specified with repo_type.

####`config_file`

The location of the configuration file.

####`log_file`

The location of the log file.

####`log_level`

The level to log at (emergency, warning, debug...)

####`proxy`

If specified, the daemon will use this proxy host to communicate back to newrelic.

####`use_ssl`

Determine if the communications back to newrelic should go over ssl.

####`ssl_ca_bundle`

Optional CA to use for ssl encryption.

####`ssl_ca_path`

Optional path to the CA to use for ssl encryption.

####`pid_file`

The path to the file that stores the daemon's pid.

####`collector_host`

The host to contact for sending data to newrelic.

####`timeout`

A timeout for how long to wait when trying to contact newrelic.

##Limitations

There is absolutely no unit/acceptance testing for this module yet.

##ToDo

* Tests are needed.
* Expand supported platforms.

###Contributors

Many thanks to PuppetLabs and their ntp module for the template to work off of.  Individual contributors can be found at: [https://github.com/adamcrews/puppet-newrelic/graphs/contributors](https://github.com/adamcrews/puppet-newrelic/graphs/contributors)
