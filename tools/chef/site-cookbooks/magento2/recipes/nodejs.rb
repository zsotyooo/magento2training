include_recipe 'nodejs'
include_recipe 'nodejs::npm'

nodejs_npm 'gulp' do
end
