# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in smps.gemspec
gemspec(name: 'smps')

group :development do
  gem 'awesome_print'
  gem 'aws_config'
  gem 'awssession'
  gem 'rake'
end

group :test do
  gem 'rspec', '~> 3.0'
  gem 'rubocop', '~> 0.57.0'
end

group :doc do
  gem 'yard'
end
