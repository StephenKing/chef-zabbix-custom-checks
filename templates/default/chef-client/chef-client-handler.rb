require 'rubygems'
require 'chef/log'
require 'chef'

module Zabbix
  class Report < Chef::Handler
    def report

      Chef::Log.info "Zabbix::Report handler started"

      prefix = "custom.chef-client.last_run"
      tempfile = "/tmp/chef-client-handler-zabbix-report.txt"
      host_name = node[:zabbix][:agent][:hostname] || node[:fqdn]
      
      message = [
        "#{host_name} #{prefix}.success #{run_status.success? ? 1 : 0}",
        "#{host_name} #{prefix}.elapsed_time #{run_status.elapsed_time}",
        "#{host_name} #{prefix}.start_time #{run_status.start_time.to_i}",
        "#{host_name} #{prefix}.end_time #{run_status.end_time.to_i}",
        "#{host_name} #{prefix}.all_resources_num #{run_status.all_resources.length}",
        "#{host_name} #{prefix}.updated_resources_num #{run_status.updated_resources.length}",
      ].join("\n")

      File.open(tempfile, 'w') {|f| f.write(message)}
      Chef::Log.debug "Sending to zabbix: #{message}" 
      Chef::Log.debug `#{node.zabbix.install_dir}/bin/zabbix_sender --config #{node.zabbix.etc_dir}/zabbix_agentd.conf --input-file #{tempfile}`
    end
  end
end
