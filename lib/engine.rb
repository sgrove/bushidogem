require 'bushido'
require 'rails'
require 'action_controller'
require 'application_helper'

module Bushido
  class Engine < Rails::Engine
    
    # Check the gem config
    initializer "check config" do |app|

      # make sure mount_at ends with trailing slash
      config.mount_at += '/'  unless config.mount_at.last == '/'
    end
        
    initializer "bushido.add_middleware" do |app|
      app.middleware.use Bushido::Middleware
    end
    
  end
end