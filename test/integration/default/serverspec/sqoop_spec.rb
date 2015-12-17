require 'serverspec'

set :backend, :exec

describe package('mapr-sqoop') do
  it { should be_installed }
end

describe file("/opt/mapr/jobs/userStore/conf/userStore_L1.options") do
  it {
    contain "import
--password-file
/opt/mapr/jobs/userStore/conf/userStore.password
"
  }
end

describe file("/opt/mapr/jobs/userStore/conf/userStore.password") do
  it {
    contain 'dummyPassword'
  }
end
