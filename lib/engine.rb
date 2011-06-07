require 'bushido'
require 'rails'
require 'action_controller'
require 'application_helper'

module Bushido
  class Engine < Rails::Engine
        
    initializer "bushido.add_middleware" do |app|
      app.middleware.use Bushido::Middleware
    end
    
  end
end