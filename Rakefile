require 'rake/testtask'
require 'rspec/core/rake_task'
require 'bundler'
Bundler::GemHelper.install_tasks

Dir['tasks/**/*.rake'].each { |rake| load rake }

task :default => :test

desc "Run bushido tests"
Rake::TestTask.new(:test) do |t|
  t.libs += ["lib", "test"]
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

desc "run rspec tests"
RSpec::Core::RakeTask.new('spec')

if ENV["RAILS_ENV"] != "production"
  require 'ci/reporter/rake/rspec'
end
