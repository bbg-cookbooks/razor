source :rubygems

gem 'rake'
gem 'minitest'
gem 'fauxhai'
gem 'foodcritic', :platforms => :ruby_19
gem 'chef', '~> 10.18.2'

group :integration do
  gem 'berkshelf', '>= 1.0.0'
  gem 'test-kitchen',    :git => 'git://github.com/opscode/test-kitchen.git', :ref => '1.0'
  gem 'kitchen-vagrant', :git => 'git://github.com/opscode/kitchen-vagrant.git'
end
