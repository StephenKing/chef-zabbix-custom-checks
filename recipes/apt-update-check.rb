#
# Author:: Steffen Gebert (<steffen.gebert@typo3.org>)
# Cookbook Name:: zabbix-custom-checks
# Recipe:: apt-update-check
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# Apache 2.0
#

include_recipe "zabbix-custom-checks::default"

template "#{node.zabbix.agent.include_dir}/apt-update-check.conf" do
  source "apt-update-check/zabbix.conf.erb"
  mode "644"
  notifies :restart, "service[zabbix_agentd]"
end