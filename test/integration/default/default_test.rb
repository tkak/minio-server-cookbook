# # encoding: utf-8

# Inspec test for recipe minio-server::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe port(9000) do
  it { should be_listening }
end

describe service('minio') do
  it { should be_enabled }
  it { should be_running }
end
