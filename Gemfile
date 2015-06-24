source 'https://rubygems.org'

gem 'rails', '4.2.2'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0' # compressor for JavaScript assets
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', git: 'http://github.com/rails/turbolinks.git'
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'figaro'
gem 'bourbon'
gem 'neat'
gem 'bcrypt', '~> 3.1.7'
gem 'intercom'
gem 'intercom-rails'
gem 'local_time'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'guard'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'awesome_print', require:"ap"
  gem 'quiet_assets'
  # gem 'rack-mini-profiler'
  # gem 'flamegraph'
end

group :test do
  gem 'capybara'
  gem 'launchy'
  gem 'selenium-webdriver'
end

group :production do
  gem 'rails_12factor'
  gem 'puma'
  gem 'newrelic_rpm'
end

ruby "2.2.2"
