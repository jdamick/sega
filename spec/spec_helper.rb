require 'simplecov'
require 'fileutils'

lib_path = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib_path) unless $LOAD_PATH.include?(lib_path)

require 'fakefs/spec_helpers'

RSpec.configure do |config|
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.default_formatter = 'documentation'
  # config.add_formatter('html')
  config.deprecation_stream = 'log/test.deprecations.log'
  config.filter_run :focus
  config.order = :random
  config.profile_examples = 10 if ENV['PROFILE_SPECS']
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    # pre-clone all of the vcr fixture data so we can use both vcr & fakefs.
    # FakeFS::FileSystem.clone(FIXTURES_DIR)
  end

  Kernel.srand config.seed
end
