maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Adds custom checks for Zabbix monitoring"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "zabbix-custom-checks::default", "Does currently nothing"
recipe "zabbix-custom-checks::apache2", "Monitors Apache2 status"
recipe "zabbix-custom-checks::apt-check-update", "Monitors for system software updates"
recipe "zabbix-custom-checks::chef-client", "Monitors results und execution time of chef run (as Zabbix traps)"
recipe "zabbix-custom-checks::nginx", "Monitors Nginx status"
recipe "zabbix-custom-checks::openvz-virtual", "Monitors OpenVZ guest status"
recipe "zabbix-custom-checks::redis", "Monitors Redis status"
recipe "zabbix-custom-checks::varnish", "Monitors Varnish status"

depends "zabbix"
depends "nginx"
depends "chef_handler"
