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

def default_ruby_system_packages
  case node['platform']
  when 'ubuntu'
    pkgs  = %w[ openssl libreadline6 libreadline6-dev
                zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev
                sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev
                ncurses-dev automake libtool bison ssl-cert ]
    case node['platform_version']
    when '10.04' then %w[ ruby ruby-dev libopenssl-ruby1.8 ] + pkgs
    when '12.04', '12.10' then %w[ ruby1.9.1 ruby1.9.1-dev ] + pkgs
    else pkgs
    end
  end
end

def default_mongo_port
  port_attr = node['mongodb'] && node['mongodb']['port']
  port_attr.nil? ? 27017 : port_attr
end

def default_postrgres_port
  port_attr = node['postgresql'] && node['postgresql']['config'] &&
    node['postgresql']['config']['port']
  port_attr.nil? ? 5432 : port_attr
end

default['razor']['bind_address']      = node['ipaddress']
default['razor']['checkin_interval']  = 60

default['razor']['persist_mode'] = "mongo"
default['razor']['persist_host'] = "127.0.0.1"
default['razor']['persist_timeout'] = 10

case node['razor']['persist_mode']
when 'postgres' then
  default['razor']['persist_port']      = self.default_postrgres_port
  default['razor']['persist_username']  = "razor"
  default['razor']['persist_password']  = "project_razor"

  default['razor']['postgres']['local_server']  = true
  default['razor']['mongo']['local_server']     = false
else
  default['razor']['persist_port'] = self.default_mongo_port

  default['razor']['postgres']['local_server']  = false
  default['razor']['mongo']['local_server']     = true

  # TODO: deprecate this attribute in 1.0.0 release
  if node['razor']['mongodb_address']
    default['razor']['persist_host'] = node['razor']['mongodb_address']
  end
end

default['razor']['images'] = Hash.new

default['razor']['ruby_system_packages']  = self.default_ruby_system_packages
default['razor']['npm_packages']          = %w[express@2.5.11 mime]
default['razor']['install_path']          = '/opt/razor'

default['razor']['bundle_cmd']  = 'bundle'
default['razor']['npm_cmd']     = 'npm'

default['razor']['app']['git_url']  = 'https://github.com/razor-provisioning/Razor.git'
default['razor']['app']['git_rev']  = '0.9.0'

default['razor']['rubygems_source']['version'] = src_version = "1.8.24"
default['razor']['rubygems_source']['url']     =
  "http://files.rubyforge.vm.bytemark.co.uk/rubygems/rubygems-#{src_version}.tgz"
