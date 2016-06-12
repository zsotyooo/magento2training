if node['mailcatcher']['enabled']
    include_recipe 'rbenv::default'
    include_recipe 'rbenv::ruby_build'

    rbenv_ruby '1.9.3-p545' do
      global true
    end

    rbenv_gem 'mailcatcher' do
      ruby_version '1.9.3-p545'
    end


    gem_package 'mailcatcher' do
        action :install
    end

    template "#{node['php']['ext_conf_dir']}/sendmail.ini" do
        source 'sendmail.ini.erb'
        owner 'root'
        group 'root'
        mode 00644
        notifies :restart, 'service[php-fpm]'
    end

    template '/etc/init.d/mailcatcher' do
        source 'mailcatcher.redhat.erb'
        owner 'root'
        group 'root'
        mode 00755
    end

    service 'mailcatcher' do
      provider Chef::Provider::Service::Init::Redhat
      supports :restart => true
      action [:enable, :start]
    end
end
