#
# Cookbook Name:: razor
# Recipe:: default
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

include_recipe 'git'
include_recipe 'build-essential'

include_recipe 'razor::_tftp'
include_recipe 'razor::_tftp_files'
include_recipe 'razor::_mongodb'
include_recipe 'razor::_postgresql'
include_recipe 'razor::_nodejs'
include_recipe 'razor::_ruby_from_package'
include_recipe 'razor::_app'
include_recipe 'razor::_add_images'
