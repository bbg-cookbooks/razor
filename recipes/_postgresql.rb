#
# Cookbook Name:: razor
# Recipe:: postgresql
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

if node['razor']['persist_mode'] == 'postgres' && node['razor']['postgres']['local_server']
  persist_username = node['razor']['persist_username']
  persist_password = node['razor']['persist_password']

  connection_info = {
    :host     => '127.0.0.1',
    :port     => node['postgresql']['config']['port'],
    :username => 'postgres',
    :password => node['postgresql']['password']['postgres']
  }

  include_recipe "postgresql::server"
  include_recipe "postgresql::ruby"

  postgresql_database_user persist_username do
    connection  connection_info
    password    persist_password
    action      :create
  end

  postgresql_database 'project_razor' do
    connection  connection_info
    owner       persist_username
    action      :create
  end
else
  include_recipe "postgresql::client"
end
