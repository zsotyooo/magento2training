
node['magento']['instances'].each do |instance_name, instance|
  cron_d "magento_system_#{instance_name}" do
    command "(cd #{instance['root_directory']} && php bin/magento cron:run)"
    minute node['magento']['cron']['minute']
    hour node['magento']['cron']['hour']
    user node['magento']['cron']['user']
  end
end
