# frozen_string_literal: true

require 'spec_helper'

describe 'emqx::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:pre_condition) do
        <<-MANIFEST
        file { '/etc/emqx/emqx.conf':
        }
        MANIFEST
      end
      let(:facts) { os_facts }
      let(:params) do
        {
          ensure: 'running',
          enable: true,
        }
      end

      it { is_expected.to contain_service('emqx') }
    end
  end
end
