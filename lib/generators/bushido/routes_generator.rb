module Bushido
  module Generators
    class RoutesGenerator < Rails::Generators::Base
  
      def create_routes_file
        prepend_to_file("config/routes.rb") do
<<-EOF
begin
  Rails.application.routes.draw do
    bushido_routes
  end
rescue => e
  puts "Error loading the Bushido routes:"
  puts "\#{e.inspect}"
end
EOF
        end

      end
    end
  end
end
