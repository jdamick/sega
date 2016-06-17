require 'bundler/gem_tasks'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require_relative 'lib/sega/rake_task'

Sega::RakeTask.new do |t|
  t.bundler_version = '1.10.6'
end

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby) do |t|
    t.fail_on_error = false if ENV['RUBOCOP_NO_FAIL']
  end
end

desc 'Run all style checks'
task style: %w(style:ruby)

$stderr.sync
$stdout.sync

desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

task default: %w(style spec)
