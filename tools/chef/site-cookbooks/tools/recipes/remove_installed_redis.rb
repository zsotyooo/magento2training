execute 'rm -f /usr/local/bin/redis-*' do
end

execute 'rm -f /etc/init.d/redis6379' do
end

execute 'rm -rf /etc/redis' do
end
