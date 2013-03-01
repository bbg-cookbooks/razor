# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'berkshelf/vagrant'
require 'kitchen/vagrant'

Vagrant::Config.run do |config|
  Kitchen::Vagrant.define_vms(config)
end
