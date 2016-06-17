require 'spec_helper'
require 'sega'
require 'sega/rake_task'
require 'rake'

ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

describe Sega do
  describe 'package' do
    let!(:rake_application) { Rake.application }

    before(:each) do
      Rake.application = Rake::Application.new
    end

    after(:each) do
      Rake.application = rake_application
    end

    subject { Sega::RakeTask.new }

    it 'should create a sega.run file' do
      orig_dir = Dir.pwd
      begin
        cleanup
        Dir.chdir(ROOT_DIR)

        expect(subject.package).to eql('sega.run')
        expect(File.exist?(File.join(ROOT_DIR, 'sega.run'))).to be_truthy
        expect(File.directory?(File.join(ROOT_DIR, 'vendor', 'cache'))).to be_truthy
      ensure
        cleanup
        Dir.chdir(orig_dir)
      end
    end

    it '.proj_name' do
      expect(subject.proj_name).to eql('sega')
    end

    it '.installer_filename' do
      expect(subject.installer_filename).to eql(File.join(ROOT_DIR, 'lib', 'sega', 'installer.erb'))
    end

    it '.installer_file' do
      inst = subject.installer_file
      expect(inst).to match(/REQUESTED_RUBY_VERSION = ">= 2.3.0"/)
      expect(inst).to match(/REQUESTED_BUNDLER_VERSION = "= 1.10.6"/)
    end

    def cleanup
      FileUtils.safe_unlink(File.join(ROOT_DIR, 'sega.run'))
      FileUtils.rmtree(File.join(ROOT_DIR, 'vendor', 'cache'))
    end
  end
end
