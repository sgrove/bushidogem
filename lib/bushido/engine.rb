#require 'bushido'

if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'rails'
  require 'rails/routes'

  module Bushido
    class Engine < Rails::Engine
        
      initializer "bushido.add_middleware" do |app|
        # Only include our middleware if its on our platform
        unless ENV['BUSHIDO_APP'].nil?
          app.middleware.use Bushido::Middleware
        end
      end
    end
  end
else
  # Rails 2 handling
  Rails.configuration.middleware.use 'Bushido::Middleware'
end
