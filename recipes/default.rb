#
# Cookbook:: minio-server
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

remote_file '/usr/local/bin/minio' do
  source 'https://dl.minio.io/server/minio/release/linux-amd64/minio'
  mode '0755'
  action :create
  not_if { ::File.exist?('/usr/local/bin/minio') }
end

directory node['minio']['volume_path'] do
  action :create
end

template '/etc/default/minio' do
  source 'minio.erb'
  mode '0644'
  variables(
    minio_volumes: node['minio']['volumes'],
    minio_opts: node['minio']['opts'],
    minio_access_key: node['minio']['access_key'],
    minio_secret_key: node['minio']['secret_key'],
    minio_domain: node['minio']['domain'],
    minio_browser: node['minio']['browser']
  )
  notifies :enable, 'service[minio]'
end

template '/etc/init.d/minio' do
  source 'minio.conf.erb'
  mode '0755'
  only_if do
    platform_family?('rhel') && node['platform_version'] == '6.10' ||
      (platform_family?('amazon') && node['platform_version'] == '2018.03')
  end
  #notifies :run, 'execute[initctl reload-configuration]', :immediately
  notifies :start, 'service[minio]'
end

template '/etc/systemd/system/minio.service' do
  source 'minio.service.erb'
  mode '0644'
  only_if do
    platform_family?('rhel') && node['platform_version'] != '6.10' ||
      platform_family?('debian') ||
      platform_family?('suse') ||
      (platform_family?('amazon') && node['platform_version'] == '2')
  end
  #notifies :run, 'execute[systemctl daemon-reload]', :immediately
  notifies :start, 'service[minio]'
end

execute 'systemctl daemon-reload' do
  action :nothing
  user 'root'
  only_if do
    platform_family?('rhel') && node['platform_version'] != '6.10' ||
      platform_family?('debian') ||
      platform_family?('suse') ||
      (platform_family?('amazon') && node['platform_version'] == '2')
  end
end

execute 'initctl reload-configuration' do
  action :nothing
  user 'root'
  only_if do
    platform_family?('rhel') && node['platform_version'] == '6.10' ||
      (platform_family?('amazon') && node['platform_version'] == '2018.03')
  end
end

service 'minio' do
  #provider Chef::Provider::Service::Systemd
  action :nothing
end
