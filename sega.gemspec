# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sega/version'

Gem::Specification.new do |spec|
  spec.name          = "sega"
  spec.version       = Sega::VERSION
  spec.authors       = ["jdamick"]
  spec.email         = ["@jeffreydamick"]

  spec.summary       = %q{Self-Extracting Gem Archive}
  spec.description   = %q{Tool that will help you create a self-extracting gem (cli) archive.}
  spec.homepage      = "https://github.com/jdamick/sega"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org" #"TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'fakefs', '~> 0.8'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'simplecov-console', '~> 0.3'
  spec.add_development_dependency 'rubocop', '~> 0.36'
end
