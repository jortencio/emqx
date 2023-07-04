require 'spec_helper_acceptance'

describe 'emqx' do
  context 'default parameters' do
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

    describe service('emqx') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(1883) do
      it { is_expected.to be_listening }
    end
  end
end
