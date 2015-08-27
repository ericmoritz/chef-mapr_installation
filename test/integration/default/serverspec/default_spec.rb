require 'serverspec'

set :backend, :exec

describe package('mapr-fileserver') do
  it { should be_installed }
end

# TODO: Fill out the default integration test
