default['nginx']['ssl_dir'] = "#{node['nginx']['dir']}/ssl"

default['varnish']['release_rpm'] = 'https://repo.varnish-cache.org/redhat/varnish-4.1.el6.rpm'
default['varnish']['VARNISH_BACKEND_ADDRESS'] = "127.0.0.1"
default['varnish']['VARNISH_BACKEND_PORT'] = 80
default['varnish']['VARNISH_BACKEND_BETWEEN_BYTES_TIMEOUT'] = '60s'
default['varnish']['VARNISH_BACKEND_FIRST_BYTE_TIMEOUT'] = '60s'
default['varnish']['trusted_servers'] = [ '127.0.0.1' ]
default['varnish']['not_cache_static_files'] = false
default['varnish']['config_dir'] = "/etc/varnish"
case platform
when "redhat", "centos", "fedora", "amazon", "scientific"
  default['varnish']['daemon_config'] = "/etc/sysconfig/varnish"
when "debian","ubuntu"
  default['varnish']['daemon_config'] = "/etc/default/varnish"
end
default['varnish']['VARNISH_LISTEN_PORT'] = 6081
default['varnish']['VARNISH_VCL_CONF'] = "/etc/varnish/default.vcl"
default['varnish']['VARNISH_ADMIN_LISTEN_ADDRESS'] = "127.0.0.1"
default['varnish']['VARNISH_ADMIN_LISTEN_PORT'] = 6082
default['varnish']['VARNISH_TTL'] = 120
default['varnish']['VARNISH_MIN_THREADS'] = 1
default['varnish']['VARNISH_MAX_THREADS'] = 1000
default['varnish']['VARNISH_SECRET_FILE'] = "/etc/varnish/secret"
default['varnish']['VARNISH_SECRET'] = 'Fv90SFa2fvo2lfEef9223FFclAwLKso2'
default['varnish']['VARNISH_WORKING_DIR'] = ''
default['varnish']['VARNISH_STORAGE'] = "malloc" # file | malloc | persistent
default['varnish']['VARNISH_STORAGE_FILE'] = "/var/lib/varnish/varnish_storage.bin"
default['varnish']['VARNISH_STORAGE_SIZE'] = "1G"

#for GeoIP2 example check the Byredo project
default['varnish']['GeoIP_enabled'] = false
default['varnish']['GeoIP2']['enabled'] = false
default['varnish']['GeoIP2']['database_location'] = '/etc/varnish/geoipdb.mmdb'
default['varnish']['GeoIP2']['environments'] = []

default['mailcatcher']['enabled'] = true

default['magento']['cron']['user'] = 'nginx'
default['magento']['cron']['minute'] = '*'
default['magento']['cron']['hour'] = '*'

default['magento']['redis']['host'] = '/var/tmp/redis.sock'
default['magento']['redis']['port'] = '6379'
default['magento']['redis']['persistent'] = ''
default['magento']['redis']['cache_database'] = '0'
default['magento']['redis']['password'] = ''
default['magento']['redis']['force_standalone'] = '0'
default['magento']['redis']['connection_retries'] = 1;
default['magento']['redis']['read_timeout'] = 10;
default['magento']['redis']['automatic_cleaning_factor'] = '0'
default['magento']['redis']['compress_data'] = '1'
default['magento']['redis']['compress_tags'] = '1'
default['magento']['redis']['compress_threshold'] = '2048'
default['magento']['redis']['compression_lib'] = 'gzip'
default['magento']['redis']['lifetime_limit'] = 57600;
