# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # rspec-expectations config goes here.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  # Rspec-mocks config goes here.
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does
    # not exist on a real object.
    mocks.verify_partial_doubles = true
  end

  # New default for rspec 4. Be future proof.
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Warn on possibly buggy code (require loops, unused vars, uninitialized vars, ...)
  config.warnings = true
end
