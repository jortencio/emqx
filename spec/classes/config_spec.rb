# frozen_string_literal: true

require 'spec_helper'

describe 'emqx::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:pre_condition) do
        <<-MANIFEST
        package { 'emqx':
        }
        MANIFEST
      end
      let(:facts) { os_facts }

      context 'manage_config is set to true' do
        let(:params) do
          {
            manage_config: true,
            node_name: 'emqx@127.0.0.1',
            node_cookie: sensitive('emqxsecretcookie'),
            node_data_dir: '/var/lib/emqx',
            node_options: {},
            cluster_name: 'emqxcl',
            cluster_discovery_strategy: 'manual',
            cluster_options: {},
            dashboard_listener_http_bind: 18_083,
            dashboard_options: {},
            authorization_deny_action: 'ignore',
            authorization_no_match: 'allow',
            authorization_cache: '{ enable = true }',
            authorization_options: {}
          }
        end

        it { is_expected.to contain_file('/etc/emqx/emqx.conf') }
      end

      context 'manage_config is set to false' do
        let(:params) do
          {
            manage_config: false,
            node_name: 'emqx@127.0.0.1',
            node_cookie: sensitive('emqxsecretcookie'),
            node_data_dir: '/var/lib/emqx',
            node_options: {},
            cluster_name: 'emqxcl',
            cluster_discovery_strategy: 'manual',
            cluster_options: {},
            dashboard_listener_http_bind: 18_083,
            dashboard_options: {},
            authorization_deny_action: 'ignore',
            authorization_no_match: 'allow',
            authorization_cache: '{ enable = true }',
            authorization_options: {}
          }
        end

        it { is_expected.not_to contain_file('/etc/emqx/emqx.conf') }
      end
    end
  end
end
