# -*- encoding: utf-8 -*-
source 'https://rubygems.org'

gem 'rake'
gem 'berkshelf'
gem 'chef-handler-profiler'
gem 'rubocop', '0.33.0'
gem 'chef-sugar'
gem 'fauxhai'

group :test do
  gem 'chefspec', '>= 3.1'
  gem 'foodcritic', '>= 3.0'
end

group :integration do
  gem 'guard', '>= 2.6'
  gem 'guard-foodcritic', '~> 1.0.0'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'guard-rubocop', '>= 1.1'
  gem 'kitchen-vagrant'
  gem 'test-kitchen', '~> 1.2.0'
  gem 'travis-lint'
end
group :development do
  gem 'webmock'
end
