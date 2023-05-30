# frozen_string_literal: true

require 'spec_helper'

describe 'emqx::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        { 
          package_source: 'https://www.emqx.com/en/downloads/broker',
          version: '5.0.25',
          platform: 'el8',
          package_extension: 'rpm',
        }
      end
      it { is_expected.to contain_file ('/tmp/emqx-5.0.25-el8-amd64.rpm')}
      it { is_expected.to contain_package('emqx') }
    end
  end
end
