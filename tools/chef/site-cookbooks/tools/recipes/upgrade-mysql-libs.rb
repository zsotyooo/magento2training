include_recipe 'yum-ius'

execute 'echo -e "remove mysql-libs \n install mysqlclient16 mysql56u-libs \n run" | yum shell -y' do
  not_if 'rpm -q mysql56u-libs'
end
