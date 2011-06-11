module ActionDispatch::Routing
  class RouteSet #:nodoc:
    Mapper.class_eval do
      def bushido_routes
        Rails.application.routes.draw do
          namespace 'bushido' do
            resources :envs, :only => [ :update, :show ]
          end
        end
      end
    end
  end
end
