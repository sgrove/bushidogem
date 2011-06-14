module Bushido #:nodoc:
  require 'optparse'
  require 'rest-client'
  require 'json'
  require 'highline/import'
  
    
  require 'engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  
  require "bushido/hooks"
  require "bushido/platform"
  require "bushido/utils"
  require "bushido/command"
  require "bushido/app"
  require "bushido/user"
  require "bushido/event"
  require "bushido/version"
  require "bushido/envs"
  require "bushido/data"
  require "bushido/middleware"
end
