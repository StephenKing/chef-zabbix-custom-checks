#
# Cookbook Name:: zabbix-custom-checks
# Recipe:: chef-client
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
include_recipe "chef_handler::default"

template "#{node.chef_handler.handler_path}/zabbix-report.rb" do
  source "chef-client/chef-client-handler.rb"
end

# We register ourself as a report handler, which runs at the end of chef run
chef_handler "Zabbix::Report" do
  source "#{node.chef_handler.handler_path}/zabbix-report.rb"
  action :enable
end