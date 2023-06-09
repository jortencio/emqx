# frozen_string_literal: true

require 'spec_helper'

describe 'emqx' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to contain_class('emqx::install') }
      it { is_expected.to contain_class('emqx::service') }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
