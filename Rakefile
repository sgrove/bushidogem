require 'rake/testtask'
require 'rspec/core/rake_task'
require 'bundler'
require 'ci/reporter/rake/rspec'
Bundler::GemHelper.install_tasks

Dir['tasks/**/*.rake'].each { |rake| load rake }

desc "Default: run all specs"
task :default => :all_specs

desc "Run all specs"
task :all_specs do
  Rake::Task["spec"].execute
  Rake::Task["dummy_specs"].execute
end

desc "run unit tests in dummy apps"
task :dummy_specs do
  Dir['spec/test_apps/**/Rakefile'].each do |rakefile|
    directory_name = File.dirname(rakefile)
    sh <<-CMD
      cd #{directory_name} && bundle exec rake
    CMD
  end
end

desc "run unit tests for gem only"
RSpec::Core::RakeTask.new('spec') do |t|
 t.pattern = '**/gem_spec/*_spec.rb'				  
end


if ENV["RAILS_ENV"] != "production"
  require 'ci/reporter/rake/rspec'
end
