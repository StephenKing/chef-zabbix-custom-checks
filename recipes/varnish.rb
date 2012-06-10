# Author:: Steffen Gebert (<steffen.gebert@typo3.org>)
# Cookbook Name:: zabbix-custom-checks
# Recipe:: varnish
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# Apache 2.0
#

include_recipe "zabbix-custom-checks::default"

template "#{node.zabbix.agent.include_dir}/varnish.conf" do
  source "varnish/zabbix.conf.erb"
  mode "644"
  notifies :restart, "service[zabbix_agentd]"
end

template "/etc/sudoers.d/zabbix-varnish" do
  source "varnish/sudoers.erb"
  mode "440"
end