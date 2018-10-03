# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smps/version'

Gem::Specification.new do |spec|
  spec.name          = 'smps'
  spec.version       = SmPs::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ['Stefan - Zipkid - Goethals']
  spec.email         = ['stefan.goethals@vrt.be']

  spec.summary       = 'SMPS - Systems Manager Parameter Store'
  spec.description   = 'SMPS - Systems Manager Parameter Store'
  spec.homepage      = 'http://github.com/vrtdev/smps'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files         = Dir.glob('lib/**/*') + %w[license.txt changelog.md README.md exe/smps]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'aws-sdk-core', '~> 3.0'
  spec.add_runtime_dependency 'aws-sdk-ssm', '~> 1.0'

  spec.required_ruby_version = '~> 2.3'
end
