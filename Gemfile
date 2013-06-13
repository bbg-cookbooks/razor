source 'https://rubygems.org'

gem 'rake'
gem 'minitest', '~> 4.7'
gem 'fauxhai'
gem 'foodcritic'

# allow CI to override the version of Chef for matrix testing
gem 'chef', (ENV['CHEF_VERSION'] || '>= 0.10.10')

group :development do
  gem 'emeril'
end

group :integration do
  gem 'berkshelf'
  gem 'test-kitchen', '~> 1.0.0.alpha.7'
  gem 'kitchen-vagrant'
end
