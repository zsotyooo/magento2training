node['magento']['instances'].each_value do |instance_details|

    configuration_script = File.join(instance_details['root_directory'].sub('current', 'shared'), 'configure-magento-config.php')

    unless File.exists? configuration_script

        if node.chef_environment == "development"
            #Use the vm's local IP address as redis host so ppl can run bin/magento from the host machine as well
            memcached_host = redis_host = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first
        else
            redis_host = instance_details['redis']['host']
            memcached_host = instance_details['memcached']['host']
        end

        mage_mode = node['nginx']['sites'][instance_details['get_magento_mode_from_this_site_config']]['mage_mode']

        template configuration_script do
            source 'configure-magento-config.php.erb'
            mode '0644'
            variables({
                :magento => node['magento'],
                :instance_details => instance_details,
                :redis_host => redis_host,
                :memcached_host => memcached_host,
                :mage_mode => mage_mode
            })
        end

    end
end
