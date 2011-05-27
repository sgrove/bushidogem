module Bushido #:nodoc:
  require 'rubygems'
  require 'optparse'
  require 'rest-client'
  require 'json'
  require 'highline/import'
  require 'yaml'

  require "bushido/platform"
  require "bushido/utils"
  require "bushido/command"
  require "bushido/app"
  require "bushido/user"
  require "bushido/events"
end
