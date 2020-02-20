source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'bootsnap', '>= 1.4.2', require: false


group :development, :test do
  gem 'byebug', platforms: [:mri]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', require: false
  gem 'spring-commands-rspec'
  gem 'overcommit'
  gem 'reek'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'json_matchers'
  gem 'rspec-json_expectations'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
end
