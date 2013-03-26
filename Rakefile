require 'rubygems'
require 'rake'
require 'rspec'
require 'rspec/core/rake_task'

# prints command to standard out and executes it
def echo_cmd(cmd)
  puts cmd
  system cmd
end

desc "Bumps Guider minor version number"
task :bump do
  # Extract version number and increment it
  version_line = IO.read("guider.gemspec").lines.grep(/s\.version = /)[0]
  version_line =~ /([0-9]+)\.([0-9]+).([0-9]+)/
  old_version = "#{$1}.#{$2}.#{$3}"
  new_version = "#{$1}.#{$2}.#{$3.to_i + 1}"
  puts "Bumping from #{old_version} to #{new_version}"

  # Replace it in guider.gemspec
  contents = IO.read("guider.gemspec")
  contents.sub!(/s\.version = '#{old_version}'/, "s.version = '#{new_version}'")
  File.open("guider.gemspec", "w") {|f| f.write(contents) }

  # Replace it in bin/guider
  contents = IO.read("bin/guider")
  contents.sub!(/VERSION = '#{old_version}'/, "VERSION = '#{new_version}'")
  File.open("bin/guider", "w") {|f| f.write(contents) }

  # Create a commit
  echo_cmd("git commit guider.gemspec bin/guider -m 'Up version to #{new_version}.'")
  # Create a tag
  echo_cmd("git tag -a v#{new_version} -m 'Tagging #{new_version} release.'")
end

desc "Build Guider gem"
task :gem do
  system "gem build guider.gemspec"
end

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ["--color"]
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => :spec
