require 'bushido'
require 'rails'
require 'rails/routes'

module Bushido
  class Engine < Rails::Engine
        
    initializer "bushido.add_middleware" do |app|
      app.middleware.use Bushido::Middleware
    end
    
  end
end
