require 'serverspec'

set :backend, :exec

describe package('mapr-fileserver') do
  it { should be_installed }
end

# The mapr uses should be able to do passwordless sudo
describe command('sudo -u mapr sudo whoami') do
  its(:stdout) { should match 'root' }
end

# TODO: Fill out the default integration test
