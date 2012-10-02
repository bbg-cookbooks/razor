#
# Cookbook Name:: razor
# Recipe:: tftp_files
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

tftp_root = node['tftp']['directory']

directory ::File.join(tftp_root, "pxelinux.cfg") do
  mode "0755"
end

%w[
  ipxe.iso
  ipxe.lkrn
  menu.c32
  pxelinux.0
  undionly.kpxe
  pxelinux.cfg/default
].each do |tftp_file|
  cookbook_file ::File.join(tftp_root, tftp_file) do
    source  tftp_file
  end
end

template ::File.join(tftp_root, "razor.ipxe") do
  source  "razor.ipxe.erb"
  variables({
    :address => node['razor']['bind_address']
  })
end
