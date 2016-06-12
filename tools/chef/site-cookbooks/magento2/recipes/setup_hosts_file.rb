node['hostfile_entries'].each do |ip_address, hosts|
    hostsfile_entry ip_address do
        hostname  hosts['main_host']
        aliases   hosts['aliases']
        action    :create
    end
end
