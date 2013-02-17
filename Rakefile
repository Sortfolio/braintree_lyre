require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--format progress"
end

desc "Default: build and run all specs"
task :default => [:spec]

desc "Clean build artifacts"
task :clean do
  `rm pkg/*.gem`
end