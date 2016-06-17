# encoding: utf-8
# frozen_string_literal: true

require 'rake'
require 'rake/tasklib'

module Sega
  INSTALLER_TEMPL = 'installer.erb'
  # Provides a custom rake task.
  #
  # require 'sega/rake_task'
  # Sega::RakeTask.new
  class RakeTask < Rake::TaskLib

    attr_accessor :ruby_version
    attr_accessor :bundler_version

    def initialize(*args, &task_block)
      @ruby_version ||= ">= 2.3.0"
      @bundler_version ||= "= 1.10.6"

      namespace "sega" do
        desc 'Run Sega Packager' unless ::Rake.application.last_description
        task(:package, *args) do |_, task_args|
          yield(*[self, task_args].slice(0, task_block.arity)) if block_given?

          package()
        end
      end
    end

    def package
      require 'yaml'
      require 'pathname'
      require 'bundler/cli'
      require 'rubygems/specification'
      require 'rubygems/package'

      Bundler::CLI.start(%w(package --all), :debug => true)

      gemspec_filename = "#{proj_name}.gemspec"
      spec = Gem::Specification.load(gemspec_filename)

      gems = Dir['vendor/cache/**/*']
      bundle_dir = Dir['.bundle/*']

      exec_tgz = "#{proj_name}.run"
      # step 1 - add the ruby installer script
      File.open(exec_tgz, "wb") do |file|
        file.write(installer_file)
      end

      File.open(exec_tgz, "a+") do |file|
        Zlib::GzipWriter.wrap(file) do |gz|
          Gem::Package::TarWriter.new(gz) do |tar|
            (spec.files + gems + bundle_dir).each do |f|

              unless File.directory?(f)
                size = File.size(f)
                mode = File.stat(f).mode & 07777
                debug "adding: #{f} size: #{size} mode: #{mode.to_s(8)}"

                input = ''
                if f == gemspec_filename # add the gemspec (post processing)
                  input = spec.to_ruby
                  size = input.size
                else
                  input = File.read(f)
                end

                tar.add_file_simple(f, mode, size) do |io|
                  io.write(input)
                end
              end
            end
          end
        end
      end

      File.chmod(0755, exec_tgz)
      debug "created: #{exec_tgz}"
      exec_tgz
    end

    def debug(msg)
      puts "[DEBUG] #{msg}" if ENV['DEBUG']
    end

    def installer_file()
      template = File.read(installer_filename)
      ERB.new(template).result(binding)
    end

    def installer_filename
      File.join(File.dirname(__FILE__), INSTALLER_TEMPL)
    end

    def proj_name
      rakefile, location = Rake.application.find_rakefile_location
      @proj_name ||= File.basename(Dir[File.join(location, "*.gemspec")].first, ".gemspec")
    end
  end
end
