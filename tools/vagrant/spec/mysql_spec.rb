require 'spec_helper'

describe package('mysql56-server') do
  it { should be_installed }
end

describe service('mysqld') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(3306) do
  it { should be_listening }
end
