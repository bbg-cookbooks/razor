#
# Cookbook Name:: razor
# Provider:: image
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

action :add do
  if !image_present?
    download_image
    add_image
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.debug("#{new_resource} is already added, so skipping")
  end
end

private

def image_present?
  send("#{new_resource.type.to_s}_image_present?")
end

def download_image
  directory ::File.dirname(image_path) do
    recursive true
    action    :nothing
  end.run_action(:create)

  remote_file image_path do
    source    new_resource.url
    checksum  new_resource.checksum if new_resource.checksum
    backup    false
    action    :nothing
  end.run_action(:create)
end

def add_image
  cmd = send("add_#{new_resource.type.to_s}_image_cmd")

  execute cmd do
    action :nothing
  end.run_action(:run)
end

def razor_bin
  ::File.join(node['razor']['install_path'], "bin/razor")
end

def file_name
  new_resource.url.split('/').last
end

def image_path
  ::File.join(Chef::Config[:file_cache_path], "razor", file_name)
end

def all_images
  Mixlib::ShellOut.new("#{razor_bin} image get").
    run_command.
    stdout.
    split("\n\n").
    collect{ |x| Hash[*(x.split(/\n|=>/) - ['Images']).collect{|y| y.strip!}] }
end

def os_image_present?
  all_images.find do |i|
    i['Type'] == "OS Install" &&
      i['ISO Filename'] == new_resource.url.split('/').last
  end
end

def mk_image_present?
  all_images.find do |i|
    i['Type'] == "MicroKernel Image" &&
      i['ISO Filename'] == new_resource.url.split('/').last
  end
end

def add_mk_image_cmd
  [ "#{razor_bin} image add --type mk",
    "--path #{image_path}"
  ].join(" ")
end

def add_os_image_cmd
  [ "#{razor_bin} image add --type os",
    "--path #{image_path}",
    "--name #{new_resource.name}",
    "--version #{new_resource.version}"
  ].join(" ")
end
