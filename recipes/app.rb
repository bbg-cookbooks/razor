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

install_path  = node['razor']['install_path']
git_url       = node['razor']['app']['git_url']
git_rev       = node['razor']['app']['git_rev']
bundle_cmd    = node['razor']['bundle_cmd']
npm_cmd       = node['razor']['npm_cmd']

git install_path do
  repository  git_url
  revision    git_rev
  action      :sync
end

# execute "#{bundle_cmd} install" do
#   cwd install_path
# end

Array(node['razor']['npm_packages']).each do |npm_pkg|
  execute "#{npm_cmd} install #{npm_pkg}"
end
