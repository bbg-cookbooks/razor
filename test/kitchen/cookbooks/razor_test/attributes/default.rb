#
# Cookbook Name:: razor_test
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

override['razor']['images'] = {
  'rz_mk_prod-image.0.9.1.6' => {
    'type'  => 'mk',
    'url'   => 'https://github.com/downloads/puppetlabs/Razor-Microkernel/rz_mk_prod-image.0.9.1.6.iso'
  },
  'precise64-mini' => {
    'url'       => 'http://archive.ubuntu.com/ubuntu/dists/precise/main/installer-amd64/current/images/netboot/mini.iso',
    'checksum'  => '7df121f07878909646c8f7862065ed7182126b95eadbf5e1abb115449cfba714',
    'version'   => '12.04'
  }
}
