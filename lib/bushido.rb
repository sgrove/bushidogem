module Bushido #:nodoc:
  require 'optparse'
  require 'rest_client'
  require 'json'
  require 'highline/import'
  require 'orm_adapter'
  require 'bushido/engine'  
  if defined?(Rails) && Rails::VERSION::MAJOR == 3
    require "action_dispatch"
  end
  require "rails/routes"
  require "bushido/base"
  require "bushido/bar"
  require "bushido/config"
  require "bushido/smtp"
  require "bushido/action_mailer"
  require "hooks"
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
  require "bushido/event_observer"
  require "bushido/mail_route"
  require "bushido/user_helper"

  # Manually require the controllers for rails 2
  if defined?(Rails) && Rails::VERSION::MAJOR == 2
    base_dir = "#{File.dirname(__FILE__)}/.."

    require "#{base_dir}/app/controllers/bushido/data_controller"
    require "#{base_dir}/app/controllers/bushido/mail_controller"
    require "#{base_dir}/app/controllers/bushido/envs_controller"
  end

  # Default way to setup Bushido. Run rails generate bushido_install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
