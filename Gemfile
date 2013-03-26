source "http://rubygems.org"

# Declare your gem's dependencies in msg.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.

gemspec
gem "jquery-rails"

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'compass-rails'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'aws-ses'
  gem 'devise' # only for testing MsgDeviseMailer
  gem 'devise-encryptable'
  gem 'haml'
  gem 'capybara'
  gem 'rspec-rails'
  gem 'watchr'
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'awesome_print'
end

