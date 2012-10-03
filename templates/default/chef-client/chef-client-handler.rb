require 'rubygems'
require 'chef/log'
require 'chef'
require 'tempfile'

module Zabbix
  class Report < Chef::Handler
    def report

      Chef::Log.info "Zabbix::Report handler started"

      prefix = "custom.chef-client.last_run"
      file = Tempfile.new('client-handler-zabbix-report')
      host_name = node[:zabbix][:agent][:hostname] || node[:fqdn]
      
      message = [
        "#{host_name} #{prefix}.success #{run_status.success? ? 1 : 0}",
        "#{host_name} #{prefix}.elapsed_time #{run_status.elapsed_time}",
        "#{host_name} #{prefix}.start_time #{run_status.start_time.to_i}",
        "#{host_name} #{prefix}.end_time #{run_status.end_time.to_i}",
        "#{host_name} #{prefix}.all_resources_num #{run_status.all_resources.length}",
        "#{host_name} #{prefix}.updated_resources_num #{run_status.updated_resources.length}",
      ].join("\n")

      file.write(message)
      cmd = [File.join(node['zabbix']['bin_dir'], "zabbix_sender"), "--config", File.join(node['zabbix']['etc_dir'], "zabbix_agentd.conf"), "--input-file", file.path]
      Chef::Log.debug "Sending to zabbix: #{message}" 
      if RUBY_VERSION < "1.9"
        Chef::Log.debug IO.popen(cmd.join(" "))
      else
        Chef::Log.debug IO.popen(cmd)
      end
      file.close!()
    end
  end
end
