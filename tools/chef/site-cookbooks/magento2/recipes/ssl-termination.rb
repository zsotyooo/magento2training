node['nginx']['ssl-termination'].each do |name, site_attrs|
    if node['nginx']['ssl-termination']
        directory "#{node['nginx']['ssl_dir']}/#{site_attrs['server_name']}" do
            mode 00755
            owner node['nginx']['user']
            action :create
            recursive true
        end
    end

    #put ssl certification in place if it is stored in the databag
    if site_attrs['ssl']['key_in_databag']
        file "#{node['nginx']['ssl_dir']}/#{site_attrs['server_name']}/#{site_attrs['ssl']['certfile']}" do
            owner 'root'
            group 'root'
            content node['ssl_certs'][name]['certificate'] + "\n"
            only_if { node['ssl_certs'] && node['ssl_certs'][name] }
        end

        file "#{node['nginx']['ssl_dir']}/#{site_attrs['server_name']}/#{site_attrs['ssl']['keyfile']}" do
            owner 'root'
            group 'root'
            content node['ssl_certs'][name]['key'] + "\n"
            only_if { node['ssl_certs'] && node['ssl_certs'][name] }
        end
    end

    #set up ssl termination
    template "#{node['nginx']['dir']}/sites-available/#{site_attrs['server_name']}-ssl-termination" do
        source 'nginx-ssl-termination-vhost.conf.erb'
        owner 'root'
        group 'root'
        mode 00644
        variables(
            :params => site_attrs
        )
    end

    nginx_site "#{site_attrs['server_name']}-ssl-termination"

    service "nginx" do
        action :reload
    end
end
