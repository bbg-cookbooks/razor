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
    case node['platform_version']
    when '10.04' then %w[ruby rubygems]
    when '12.04' then %w[ruby1.9.3]
    end
  end
end

default['razor']['ruby_system_packages']  = Array(ruby_system_packages)
default['razor']['npm_packages']          = %w[express@2.5.11 mime]
default['razor']['install_path']          = '/opt/razor'
default['razor']['bundle_cmd']            = 'bundle'
default['razor']['npm_cmd']               = 'npm'
default['razor']['app']['git_url']        = 'https://github.com/puppetlabs/Razor.git'
default['razor']['app']['git_rev']        = 'master'

default['nodejs']['install_method'] = 'package'
