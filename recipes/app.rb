#
# Cookbook Name:: razor
# Recipe:: app
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

bind_address      = node['razor']['bind_address']
install_path      = node['razor']['install_path']
git_url           = node['razor']['app']['git_url']
git_rev           = node['razor']['app']['git_rev']
bundle_cmd        = node['razor']['bundle_cmd']
npm_cmd           = node['razor']['npm_cmd']
mongodb_address   = node['razor']['mongodb_address']
checkin_interval  = node['razor']['checkin_interval']

git install_path do
  repository  git_url
  revision    git_rev
  action      :sync
end

execute "#{bundle_cmd} install --without test" do
  cwd install_path
end

Array(node['razor']['npm_packages']).each do |npm_pkg|
  execute "#{npm_cmd} install #{npm_pkg}" do
    cwd install_path
  end
end

directory "/usr/local/bin" do
  recursive true
end

template "/usr/local/bin/razor" do
  source  "razor_bin.erb"
  mode    "0755"
  variables({
    :directory => install_path
  })
end

template ::File.join(install_path, %w[conf razor_server.conf]) do
  source  "razor_server.conf.erb"
  mode    "0755"
  variables({
    :address              => bind_address,
    :persist_host         => mongodb_address,
    :directory            => install_path,
    :mk_checkin_interval  => checkin_interval
  })

  notifies :restart, "service[razor]"
end

template "/etc/init.d/razor" do
  source  "razor.erb"
  mode    "0755"
  variables({
    :directory => install_path
  })

  notifies :restart, "service[razor]"
end

service "razor" do
  supports  :status => true, :restart => true, :reload => false
  action    [ :enable, :start ]
end
