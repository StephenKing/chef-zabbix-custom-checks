# <a name="title"></a> zabbix-custom-checks

## <a name="description"></a> Description

Collection of custom checks for the [Zabbix][zabbix-website] monitoring software used in the Server Admin team of the [TYPO3] project.

## <a name="usage"></a> Usage

Include the specific recipe in the node's run list and load the according `zabbix_template.xml` into Zabbix. Please note: If you are *not* using active checks, you have to change the type of monitored objects from *Zabbix agent (active)* to *Zabbix agent*. Zabbix uses passive checks by default, which lets the Zabbix server/proxy collect the statistics.

Some recipies require *sudo* privileges. The recipies will put a file into `/etc/sudoers.d/`, thus make sure that your `/etc/sudoers` includes files from there. This can be achieved by including the following line in `/etc/sudoers:

    #includedir /etc/sudoers.d
  
(note that the trailing `#` does *not* mean the line is commented out!)

## <a name="requirements"></a> Requirements

### <a name="requirements-chef"></a> Chef

Tested on 0.10.8 and 0.10.10 but newer and older version should work just
fine.

### <a name="requirements-platform"></a> Platform

The following platforms have been tested with this cookbook, meaning that
the recipes and LWRPs run on these platforms without error:

* ubuntu (10.04)
* debian (6.0)

Please [report][issues] any additional platforms so they can be added.

### <a name="requirements-cookbooks"></a> Cookbooks

These cookbooks are defined as external dependencies:

* [zabbix-cookbook]
* [nginx]
* [chef_handler]

All of them are available through the Opscode [community site][opscommunity].


## <a name="recipes"></a> Recipes

### <a name="recipes-default"></a> default

Does nothing currently...

### <a name="recipes-apache2"></a> apache2

Monitors **Apache 2** through the output of `mod_status` at `/server-status`. Sets up an extra vHost on Port 61709 in order to not conflict with a reverse proxy (exposing the server-status to the outside world).

Credits for the check script go to [rdvn].

### <a name="recipes-apt-update-check"></a> apt-update-check

Monitors the output of `apt-check` and reports, whether security or normal updates for installed apt-packages are available. Requires to run `apt-get update` regularly, etc. through the [apt] cookbook.

### <a name="recipes-chef-client"></a> chef-client

Monitors the duration of `chef-client` runs and the success status. Failed runs and continuously slow execution (>60 seconds) are reported. Makes use of [chef_handler] and registers as a [report handler][chef-wiki-handler].

### <a name="recipes-nginx"></a> nginx

Monitors **Nginx** through the output of `HttpStubStatusModule` at `/server_status`. This means that Nginx has to be compiled with `--with-http_stub_status_module`.

### <a name="recipes-nginx"></a> nginx

Monitors **Nginx** through the output of `HttpStubStatusModule` at `/nginx_status`. This means that Nginx has to be compiled with `--with-http_stub_status_module`. The port of the virtual host can be defined through `node[:zabbix_custom_checks][:nginx][:port]`.

Credits for the check script go to [zabbixtemplates.com].

### <a name="recipes-openvz-virtual"></a> openvz-virtual

Monitors **OpenVZ VEs** from inside the container through the output of `/proc/user_beancounter`. Alerts on exceeding the limits through a *beancount monitor*.

### <a name="recipes-redis"></a> redis

Monitors **redis** through the output of `redis-cli info`.

Credits for the check script go to [rdvn].

### <a name="recipes-varnish"></a> varnish

Monitors **varnish** through the output of `varnishstat`.

Credits for the check script go to [rdvn].




## <a name="attributes"></a> Attributes

* `node[:zabbix_custom_checks][:nginx][:port]` to change the port, where `/nginx_status` is available.


## <a name="license"></a> License and Author

Author:: [Steffen Gebert][stephenking] (<steffen.gebert@typo3.org>)

Copyright 2011, 2012, Steffen Gebert for TYPO3 Association

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[issues]:				https://github.com/StephenKing/chef-zabbix-custom-checks/issues

[opscommunity]:			http://community.opscode.com/cookbooks
[zabbix-cookbook]:		http://community.opscode.com/cookbooks/zabbix
[nginx]:				http://community.opscode.com/cookbooks/nginx
[chef_handler]:			http://community.opscode.com/cookbooks/chef_handler
[apt]:					http://community.opscode.com/cookbooks/apt

[zabbix-website]:		http://www.zabbix.com
[typo3]:				http://typo3.org
[stephenking]:  		http://github.com/stephenking/
[rdvn]:					https://github.com/rdvn/zabbix-templates
[chef-wiki-handler]:	http://wiki.opscode.com/display/chef/Exception+and+Report+Handlers
[zabbixtemplates.com]:	http://zabbixtemplates.com/node/11