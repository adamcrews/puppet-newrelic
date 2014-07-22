require 'spec_helper'

describe 'newrelic' do
  [ 'Windows', 'Solaris' ].each do |system|
    describe "Fail on unsupported os" do
      let(:facts) {{ :osfamily => system }}
      let(:params) {{ :license => 'a-fake-license' }}
      it do
        expect { is_expected.to compile }.to raise_error(Puppet::Error)
      end
    end
  end # end of system loop

  [ 'RedHat', 'Debian' ].each do |system|

    let(:facts) {{ 
      :osfamily   => system,
      :lsbdistid  => system,
    }}

    describe "without a license" do
      it do
        expect { is_expected.to compile }.to raise_error(Puppet::Error)
      end
    end

    describe "with a non-string license" do
      it do
        expect { is_expected.to compile }.to raise_error(Puppet::Error)
      end
    end

    describe "with a license" do
      let(:params) {{ 
        :license        => 'a-fake-license',
      }}

      it { is_expected.to contain_class('newrelic::install') }
      it { is_expected.to contain_class('newrelic::config') }
      it { is_expected.to contain_class('newrelic::service') }

      describe "newrelic::install on #{system}" do
        let(:params) {{
          :license      => 'a-fake-license',
        }}
        it { is_expected.to contain_package('newrelic').with_ensure('present') }

        describe "should allow package ensure to be overriden" do
          let(:params) {{
            :license        => 'a-fake-license',
            :package_ensure => 'absent'
          }}
          it { is_expected.to contain_package('newrelic').with_ensure('absent') }
        end

        describe "should optionally not manage a repo" do
          let(:params) {{
            :license => 'a-fake-license',
            :repo_manage => false,
          }}
          it do
            is_expected.not_to contain_apt__source('newrelic')
            is_expected.not_to contain_yumrepo('newrelic')
          end
        end

        describe "should create a repo" do
          let(:params) {{
            :license => 'a-fake-license',
            :repo_manage => true,
          }}
          if system == 'Debian'
            it { is_expected.to contain_apt__source('newrelic') }
          elsif system == 'RedHat'
            it { is_expected.to contain_yumrepo('newrelic') }
          end
        end
      end
    end
    
  end # end of system loop
end   # end of describe 'newrelic'

at_exit { RSpec::Puppet::Coverage.report! }
