#
# Cookbook Name:: razor
# Recipe:: rubygems_from_source
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

src_version = node['razor']['rubygems_source']['version']
src_url     = node['razor']['rubygems_source']['url']
tar_file    = ::File.join(Chef::Config[:file_cache_path], src_url.split("/").last)
src_dir     = tar_file.sub(/\.tgz/, '')

remote_file tar_file do
  source src_url
end

directory src_dir do
  mode      '0755'
  recursive true
end

execute "Extracting #{tar_file} to #{src_dir}" do
  command "tar -xzf #{tar_file} --strip-components=1 -C #{src_dir}"
  creates ::File.join(src_dir, "setup.rb")
end

execute "Installing rubygems-#{src_version}" do
  cwd     src_dir
  command "ruby setup.rb --no-format-executable"
  creates "/usr/bin/gem"
end
