version = node['formatron_influxdb']['version']
checksum = node['formatron_influxdb']['checksum']

ldap_server = node['formatron_influxdb']['ldap_server']
ldap_port = node['formatron_influxdb']['ldap_port']
ldap_search_base = node['formatron_influxdb']['ldap_search_base']
ldap_bind_dn = node['formatron_influxdb']['ldap_bind_dn']
ldap_bind_password = node['formatron_influxdb']['ldap_bind_password']
ldap_uid = node['formatron_influxdb']['ldap_uid']

cache = Chef::Config[:file_cache_path]
deb = File.join cache, 'influxdb.deb'
deb_url = "http://influxdb.s3.amazonaws.com/influxdb_#{version}_amd64.deb"

remote_file deb do
  source deb_url
  checksum checksum
end

dpkg_package 'influxdb' do
  source deb
end

template '/etc/influxdb/influxdb.conf' do
  variables(
  )
  notifies :restart, 'service[influxdb]', :delayed
end

service 'influxdb' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
