#
# Cookbook:: minio-server
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

remote_file '/usr/local/bin/minio' do
  source 'https://dl.minio.io/server/minio/release/linux-amd64/minio'
  mode '0755'
  action :create
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
    minio_secret_key: node['minio']['secret_key']
  )
  notifies :restart, 'service[minio]'
end

cookbook_file '/etc/systemd/system/minio.service' do
  source 'minio.service'
  action :create
  notifies :run, 'execute[systemctl daemon-reload]', :immediately
end

execute 'systemctl daemon-reload' do
  action :nothing
  user 'root'
end

service 'minio' do
  provider Chef::Provider::Service::Systemd
  action [:start, :enable]
end
