include_recipe 'apt::default'

node.override['apache']['default_site_enabled'] = false
include_recipe 'apache2::default'

include_recipe 'formatron_influxdb::default'
apache_site 'influxdb'
