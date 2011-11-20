module Bushido #:nodoc:
  require 'optparse'
  require 'rest_client'
  require 'json'
  require 'highline/import'
  require 'orm_adapter'
  require 'engine'  
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require "action_dispatch"
  end
  require "rails/routes"
  require "bushido/base"
  require "bushido/config"
  require "bushido/action_mailer"
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
  require "bushido/models"
  require "bushido/schema"

  # Default way to setup Bushido. Run rails generate bushido_install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
