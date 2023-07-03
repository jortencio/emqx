require 'spec_helper_acceptance'

describe 'emqx' do
  context 'default parameters'
  let(:pp) do
    <<-MANIFEST
      class { 'emqx': }
    MANIFEST
  end

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe package('emqx') do
    it { is_expected.to be_installed }
  end

  describe port(18_083) do
    it { is_expected.to be_listening }
  end

  describe service('emqx') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_running }
  end
end
