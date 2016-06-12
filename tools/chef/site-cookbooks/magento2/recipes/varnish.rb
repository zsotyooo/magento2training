if node['varnish']['GeoIP2']['enabled']

    packages = [ "unzip", "python-docutils", "varnish-libs-devel", "libmaxminddb-devel", "autoconf", "automake", "libtool"]

    packages.each do |pkg|
        package pkg do
            action :install
        end
    end
end

if platform?("redhat", "centos", "fedora", "amazon", "scientific")
    bash "varnish-cache.org" do
        user "root"
        code <<-EOH
            rpm -q varnish || rpm --nosignature -i #{node['varnish']['release_rpm']}
        EOH
    end
    ruby_block "Flush yum cache" do
        block do
            Chef::Provider::Package::Yum::YumCache.instance.reload
        end
    end
end

if platform?("ubuntu", "debian")
    include_recipe "apt"
    apt_repository "varnish-cache.org" do
        uri "http://repo.varnish-cache.org/#{:platform}/"
        distribution node['lsb']['codename']
        components ["main"]
        key "http://repo.varnish-cache.org/debian/GPG-key.txt"
        deb_src true
        notifies :run, resources(:execute => "apt-get update"), :immediately
    end
end

pkgs = value_for_platform(
    [ "centos", "redhat", "fedora" ] => {
        "default" => %w{ varnish-release varnish }
    },
    [ "debian", "ubuntu" ] => {
        "default" => %w{ varnish }
    }
)

pkgs.each do |pkg|
    package pkg do
        action :install
    end
end

template "#{node['varnish']['config_dir']}/default.vcl" do
    source "varnish.vcl.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
        :varnish => node['varnish']
    )
end

template node['varnish']['daemon_config'] do
    source "varnish.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
        :params => node['varnish']
    )
end

if node['varnish']['GeoIP2']['enabled']

    unless File.exist? '/tmp/libvmod-geoip2.zip'
        bash 'download libgoip2 varnish module' do
            code 'wget --no-clobber --no-check-certificate --output-document=/tmp/libvmod-geoip2.zip https://github.com/fgsch/libvmod-geoip2/archive/master.zip'
        end
    end

    unless File.directory? '/tmp/libvmod-geoip2-master'
        bash 'uncompress libgoip2 varnish module' do
            cwd '/tmp'
            code 'unzip libvmod-geoip2.zip'
        end
    end

    unless File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so'
        bash 'prepare configuration libgoip2 varnish module' do
            cwd '/tmp/libvmod-geoip2-master'
            code './autogen.sh'
        end
    end

    unless File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so'
        bash 'configure building libgoip2 varnish module' do
            cwd '/tmp/libvmod-geoip2-master'
            code './configure'
        end
    end

    unless File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so'
        bash 'build libgoip2 varnish module' do
            cwd '/tmp/libvmod-geoip2-master'
            code 'make'
        end
    end

    unless File.exist? '/usr/lib64/varnish/vmods/libvmod_geoip2.so'
        bash 'install libgoip2 varnish module' do
            cwd '/tmp/libvmod-geoip2-master'
            code 'make install'
        end
    end

    template "#{node['varnish']['config_dir']}/geoip.vcl" do
        source "geoip.vcl.erb"
        owner "root"
        group "root"
        mode 0644
        variables(
            :varnish => node['varnish']
        )
    end

    unless File.exist? '/tmp/GeoLite2-Country.mmdb.gz'
        bash 'download geoip2 database' do
            code 'wget --no-clobber --output-document=/tmp/GeoLite2-Country.mmdb.gz http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.mmdb.gz'
        end
    end

    unless File.exist? '/tmp/GeoLite2-Country.mmdb'
        bash 'uncompress geoip2 database' do
            cwd '/tmp'
            code "rm -f GeoLite2-Country.mmdb && gunzip GeoLite2-Country.mmdb.gz"
        end
    end

    unless File.directory? '/tmp/GeoLite2-Country.mmdb.gz'
        bash 'move geoip2 database to the permanent location' do
            cwd '/tmp'
            code "mv GeoLite2-Country.mmdb #{node['varnish']['GeoIP2']['database_location']}"
        end
    end

end

service "varnish" do
    supports :restart => true, :reload => true
    action [ :enable, :start ]
end

service "varnishlog" do
    supports :restart => true, :reload => true
    action [ :enable, :start ]
end

bash 'update varnish secret' do
    user 'root'
    code "echo '#{node['varnish']['VARNISH_SECRET']}' > #{node['varnish']['VARNISH_SECRET_FILE']} && chmod 600 #{node['varnish']['VARNISH_SECRET_FILE']}"
    notifies :restart, "service[varnish]", :delayed
end
