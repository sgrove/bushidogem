module Bushido
  module Generators
    class HooksGenerator < Rails::Generators::Base
        
      def create_hooks_file

        lib("bushido/hooks/user_hooks.rb") do
<<-EOF
class BushidoUserHooks < Bushido::EventObserver
  def user_added
    user.create(:email  => params['data']['email'],
      :ido_id => params['data']['ido_id'],
      :active => true)
  end

  def user_removed
    User.find_by_ido_id(params['data']['ido_id']).try(:disable!)
  end
end
EOF
        end
        
        lib('bushido/hooks/app_hooks.rb') do
<<-EOF
class BushidoAppHooks < Bushido::EventObserver
  def app_claimed
    User.find(1).update_attributes(:email  => params['data']['email'],
      :ido_id => params['data']['ido_id'])
  end
end
EOF
        end
        
        initializer "bushido_hooks.rb" do
<<-EOF
Dir["\#{Dir.pwd}/lib/bushido/**/*.rb"].each { |file| require file }
EOF
        end
      end

    end
  end
end
