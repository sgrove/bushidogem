ENV["RAILS_ENV"] = "test"
require "rubygems"
require "bundler"
Bundler.setup

require "dummy/config/environment"
require "rails/test_help"
require "rails/generators/test_case"