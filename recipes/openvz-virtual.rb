# Author:: Steffen Gebert (<steffen.gebert@typo3.org>)
# Cookbook Name:: zabbix-custom-checks
# Recipe:: openvz-virtual
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# Apache 2.0
#

include_recipe "zabbix-custom-checks::default"

template "#{node.zabbix.agent.include_dir}/openvz-virtual.conf" do
	source "openvz/virtual/zabbix.conf.erb"
	mode "644"
	notifies :restart, "service[zabbix_agentd]"
end	

# custom monitoring scripts
files = ["beancount-failcnt.py", "beancount-monitor.py"]
files.each do |filename|
	template "#{node.zabbix.external_dir}/openvz-virtual-#{filename}" do
		source "openvz/virtual/#{filename}.erb"
		mode "755"
	end
end

template "/etc/sudoers.d/zabbix-openvz-virtual" do
	source "openvz/virtual/sudoers.erb"
	mode "440"
end