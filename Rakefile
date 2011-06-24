require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc "Run bushido tests"
Rake::TestTask.new(:test) do |t|
  t.libs += ["lib", "test"]
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end