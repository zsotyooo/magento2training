node['magento']['instances'].each do |instance_name, instance_details|
    configuration_script = File.join(instance_details['root_directory'].sub('current', 'shared'), 'install-magento2.sh')

    unless File.exists? configuration_script
        if node.chef_environment == "development"
            #Use the vm's local IP address as db host so ppl can run bin/magento from the host machine as well
            db_host = node[:network][:interfaces][:eth1][:addresses].detect{|k,v| v[:family] == "inet" }.first
        else
            db_host = instance_details['db']['host']
        end

        template configuration_script do
            source 'install-magento2.sh.erb'
            mode '0644'
            variables({
                :magento => node['magento'],
                :instance_details => instance_details,
                :db_host => db_host,
                :db_password => node['mysql']['users'][instance_details['db']['username']]['password']
            })
        end
    end
end
