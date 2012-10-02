#
# Cookbook Name:: razor
# Attributes:: default
#
# Author:: Fletcher Nichol (<fnichol@nichol.ca>)
#
# Copyright 2012, Blue Box Group, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

def ruby_system_packages
  case node['platform']
  when 'ubuntu'
    pkgs  = %w[ openssl libreadline6 libreadline6-dev
                zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev
                sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev
                ncurses-dev automake libtool bison ssl-cert ]
    case node['platform_version']
    when '10.04' then %w[ ruby ruby-dev libopenssl-ruby1.8 ] + pkgs
    when '12.04' then %w[ ruby1.9.1 ruby1.9.1-dev ] + pkgs
    end
  end
end

default['razor']['ruby_system_packages']  = ruby_system_packages
default['razor']['npm_packages']          = %w[express@2.5.11 mime]
default['razor']['install_path']          = '/opt/razor'

default['razor']['bundle_cmd']            = 'bundle'
default['razor']['npm_cmd']               = 'npm'

default['razor']['app']['git_url']        = 'https://github.com/puppetlabs/Razor.git'
default['razor']['app']['git_rev']        = 'master'

default['razor']['rubygems_source']['version'] = src_version = "1.8.24"
default['razor']['rubygems_source']['url']     =
  "http://files.rubyforge.vm.bytemark.co.uk/rubygems/rubygems-#{src_version}.tgz"
