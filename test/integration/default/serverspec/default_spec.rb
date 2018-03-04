require 'spec_helper'

describe file('/etc/modules-load.d/chef-drbd.conf') do
  it { should be_file }
  its(:content) { should match('drbd') }
end

describe file('/etc/modules-load.d/chef-8021q.conf') do
  it { should be_file }
  its(:content) { should match('8021q') }
end
