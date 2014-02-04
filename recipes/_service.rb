#
# Cookbook Name:: razor
# Recipe:: _service
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

case node['razor']['service_type']
when "sysvinit"
  template "/etc/init.d/razor" do
    source  "razor.erb"
    mode    "0755"
    variables({
      :directory => node['razor']['install_path']
    })
  
    notifies :restart, "service[razor]"
  end
  
  service "razor" do
    supports  :status => true, :restart => true, :reload => false
    action    [ :enable, :start ]
  end
when "upstart"
  template "/etc/init/razor.conf" do
    source "razor.upstart.erb"
    mode "0644"
    variables(
      :install_path => node['razor']['install_path']
    )
    notifies :stop, "service[razor]"
    notifies :start, "service[razor]"
  end

  service "razor" do
    provider Chef::Provider::Service::Upstart
    supports  :status => true, :restart => true, :reload => false
    action    [ :enable, :start ]
  end
end
