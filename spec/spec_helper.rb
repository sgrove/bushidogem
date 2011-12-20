ENV["RAILS_ENV"] = "test"

require 'bundler/setup'
require 'cover_me'
require 'rails'
require "rails/test_help"
require 'rspec/rails'

$:.unshift File.dirname(__FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'bushido'

CoverMe.config do |c|
    # where is your project's root:
    c.project.root = File.expand_path('../..', __FILE__)
end

RSpec.configure do |config|
  # not yet decided on what to configure here
end
