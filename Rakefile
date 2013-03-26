require 'rubygems'
require 'rake'
require 'rspec'
require 'rspec/core/rake_task'

desc "Build Guider gem"
task :gem do
  compress
  system "gem build guider.gemspec"
end

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["--color"]
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
