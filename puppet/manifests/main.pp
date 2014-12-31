# librarian-puppet would have downloaded and installed the required modules
# now is the time to use them to install the required applications


# Set path for exec
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }


## Timezone
# Change as needed to a value shown by the command 'timedatectl list-timezones' on Ubuntu.
class { 'timezone':
  timezone => 'America/Los_Angeles',
}


## Apt

# Include apt first
class { 'apt':
	always_apt_update => false,
}
# Add PPA repos. Removed maven repo as Trusty has maven3 by default.
apt::ppa { 'ppa:webupd8team/java': }   # Oracle JDK 6/7/8
apt::ppa { 'ppa:chris-lea/node.js': }  # nodejs
# apt update
exec { 'apt-update':
	command 	=> 'apt-get update',
}


## Java

# Manage Oracle license
exec { 'set-license-selected':
		command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections',
}
package { 'oracle-java7-installer':
  ensure  	=> 'installed',
  require  	=> Exec['set-license-selected'],  # ensure license is handled 
}
package { 'oracle-java7-set-default':
	ensure 		=> 'installed',
}
# Ensure Java ppa is added and then install the two packages
Apt::Ppa['ppa:webupd8team/java'] -> Exec['apt-update'] -> Package['oracle-java7-installer'] -> Package['oracle-java7-set-default'] 


## Maven

# Install Maven after Oracle JDK 
package { 'maven':
  ensure  	=> 'installed',
  require 	=> Package['oracle-java7-set-default'],
}
# Ensure maven is installed after JDK. Once Maven is installed configure the local m2 repo path.
Package['maven'] -> Exec['update_maven_repo_path']


## Nodejs and yeoman
  
# Install nodejs, yeoman, grunt cli and bower
package { 'nodejs':
  ensure  	=> 'installed',
}
# Install yeoman (since our npm version is > 1.2.10 we do not need to install grunt-cli and bower explicitly
exec { 'install-yo':
  command 	=> 'npm -g install yo',
}
# Ensure nodejs ppa is added befre trying to install nodejs and yeoman9
Apt::Ppa['ppa:chris-lea/node.js'] -> Exec['apt-update'] -> Package['nodejs'] -> Exec['install-yo']


## Mongodb
# Configure globals for the mongodb module
class { '::mongodb::globals':
  manage_package_repo => true,
  version => '2.6.6',
}
# Configure mongodb server
class { '::mongodb::server':
  ensure => true,
  dbpath => '/home/vagrant/mongodata',  # mongoddb does not support vboxsf file system type, so cannot use shared folder
  directoryperdb  => true,
}  
class { '::mongodb::client': }
Class['::mongodb::globals'] -> Class['::mongodb::server'] -> Class['::mongodb::client']


# Update the maven repo in settings.xml
# Ideally should be done with Augeas and XML lens but getting constant errors.
# Implementing workaround for now using sed

exec { 'update_maven_repo_path':
	command		=> "sed -i '55i  <localRepository>/home/vagrant/m2</localRepository>' /usr/share/maven/conf/settings.xml",
}