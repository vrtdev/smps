# frozen_string_literal: true

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'yard/rake/yardoc_task'
require 'smps/version'

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

desc 'Build gem into the pkg directory'
task :build do
  FileUtils.rm_rf('pkg')
  Dir['*.gemspec'].each do |gemspec|
    system "gem build #{gemspec}"
  end
  FileUtils.mkdir_p('pkg')
  FileUtils.mv(Dir['*.gem'], 'pkg')
end

def changelog
  log = File.read('changelog.md').split("\n\n")
  unreleased_index = log.index { |k| k =~ %r{\[Unreleased\]} }
  log[unreleased_index + 1]
end

desc 'Displays the latests changelog entry'
task :changelog do
  puts changelog
end

desc 'Tags version, pushes to remote, and pushes gem'
task release: :build do
  sh 'git', 'tag', '-m', changelog, "v#{SmPs::VERSION}"
  # sh 'git push origin master'
  # sh "git push origin v#{SmPs::VERSION}"
  # sh 'ls pkg/*.gem | xargs -n 1 gem push'
end

task doc: :yard
task default: :spec
