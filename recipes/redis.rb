# Author:: Steffen Gebert (<steffen.gebert@typo3.org>)
# Cookbook Name:: zabbix-custom-checks
# Recipe:: redis
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# Apache 2.0
#

include_recipe "zabbix-custom-checks::default"

template "#{node.zabbix.agent.include_dir}/redis.conf" do
  source "redis/zabbix.conf.erb"
  mode "644"
  notifies :restart, "service[zabbix_agentd]"
end

template "/etc/sudoers.d/zabbix-redis" do
  source "redis/sudoers.erb"
  mode "440"
end