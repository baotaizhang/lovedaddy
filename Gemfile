source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'config'
gem 'dotenv-rails'
gem 'enumerize'
gem 'seed-fu'
gem 'ransack'
gem 'kaminari'
gem 'carrierwave'
gem 'mini_magick', '~> 4.8'
gem 'fog-aws'
gem 'jp_prefecture'
gem 'slim-rails'
gem 'draper'
gem 'active_hash'

# form
gem "cocoon"

# SEO
gem 'meta-tags'

# CSS
gem 'sass-rails', '~> 5.0'
gem 'autoprefixer-rails'

# JS
gem 'coffee-rails', '~> 4.2'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'

# Auth
gem 'sorcery'
gem 'cancancan', '~> 2.0'
gem 'draper-cancancan'

# Error handling
gem 'rambulance'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-coolline'
  gem 'pry-stack_explorer'
  gem 'timecop'
  gem 'awesome_print'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'license_finder'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'rack-mini-profiler'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'annotate'
  gem 'letter_opener'
  gem 'letter_opener_web', '~> 1.0'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'faker'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rspec-power_assert'
  gem 'rspec-validator_spec_helper'
  gem 'rspec-parameterized'
  gem 'chromedriver-helper'
end

group :production, :staging do
  gem 'unicorn'
  gem 'therubyracer', platforms: :ruby
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
