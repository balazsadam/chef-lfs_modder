resource_name :modder

property :mod, String, name_property: true

action :load do
  cmd = Mixlib::ShellOut.new("/sbin/lsmod | /bin/grep -q #{mod}")
  cmd.run_command
  if cmd.exitstatus == 1
    cmd = Mixlib::ShellOut.new("/sbin/modprobe #{mod}")
    cmd.run_command
    if cmd.exitstatus == 0
      template 'modulefile' do
        path "/etc/modules-load.d/chef-#{mod}.conf"
        cookbook 'lfs_modder'
        source 'modules.erb'
        variables ({
          :mod => mod
        })
        owner 'root'
        group 'root'
        mode 00644
      end
    else
      Chef::Log.warn("#{mod} is not compatible, we will skip it for good.")
    end
  else
    Chef::Log.info("#{mod} is already loaded, nothing to do.")
  end
end

action :remove do
  cmd = Mixlib::ShellOut.new("/sbin/modprobe -r #{mod}")
  cmd.run_command
  file "/etc/modules-load.d/chef-#{mod}.conf" do
    ignore_failure true
    action :delete
  end
end

action :blacklist do
  template 'modulefile' do
    path "/etc/modules-load.d/chef-#{mod}.conf"
    cookbook 'lfs_modder'
    source 'modules-blacklist.erb'
    variables ({
        :mod => mod
    })
    owner 'root'
    group 'root'
    mode 00644
  end
end
