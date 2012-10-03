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
      file.close()
      cmd = [File.join(node['zabbix']['bin_dir'], "zabbix_sender"), "--config", File.join(node['zabbix']['etc_dir'], "zabbix_agentd.conf"), "--input-file", file.path]
      Chef::Log.debug "Sending to zabbix: #{message}"
      Chef::Log.debug "Command #{cmd.join(" ")}"
      if RUBY_VERSION < "1.9"
        out = IO.popen(cmd.join(" "))
      else
        out = IO.popen(cmd)
      end
      Chef::Log.debug "output #{out.readlines}"
      out.close
    end
  end
end
