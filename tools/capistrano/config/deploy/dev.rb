set :deploy_to, "/tmp/test" # Deploys to VM not presently supported
set :branch, "develop"

ssh_options[:keys] = [File.join(ENV['HOME'], '.vagrant.d', 'insecure_private_key')]
server "vagrant@magento2training.dev", :app, :primary => true