require 'spec_helper_acceptance'

describe 'EMQX Message Broker', if: ['redhat'].include?(os[:family]) do
  let(:pp) do
    <<-MANIFEST
      include emqx
    MANIFEST
  end

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  describe port(18083) do
    it { is_expected.to be_listening }
  end
end