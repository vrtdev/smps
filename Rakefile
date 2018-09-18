# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'

RSpec::Core::RakeTask.new(:spec)

RuboCop::RakeTask.new(:rubocop) do |task|
  task.formatters = %w[fuubar offenses]
  task.fail_on_error = true
end

YARD::Rake::YardocTask.new do |task|
  # task.files   = ['lib/**/*.rb']
  task.options = ['--readme', 'README.md', '--files', 'license.txt']
  task.stats_options = ['--list-undoc']
end

task doc: :yard
task default: :spec
