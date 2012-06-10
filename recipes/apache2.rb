#
# Cookbook Name:: zabbix-custom-checks
# Recipe:: apache2
#
# Copyright 2012, Steffen Gebert / TYPO3 Association
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "zabbix-custom-checks::default"

template "#{node.zabbix.agent.include_dir}/apache2.conf" do
	source "apache2/apache2.conf.erb"
	mode "644"
	notifies :restart, "service[zabbix_agentd]"
end	

template "#{node.zabbix.external_dir}/apache2_status.sh" do
	source "apache2/apache2_status.sh.erb"
	mode "755"
end

include_recipe "apache2::mod_status"

web_app "server-status" do
  template "apache2/web_app.conf.erb"
end