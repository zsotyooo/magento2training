require 'spec_helper'
require 'net/http'

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/nginx/sites-enabled/magento2training.dev') do
  it { should be_file }
  its(:content) { should match /server_name .*magento2training.dev.*/ }
end

describe "HTTP OK" do
  it do
    Net::HTTP.get_response(URI.parse('http://magento2training.dev')).should be_a Net::HTTPOK
  end
end
