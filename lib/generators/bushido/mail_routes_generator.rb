module Bushido
  module Generators
    class MailRoutesGenerator < Rails::Generators::Base
  
      def create_mail_routes_file
        # Create the lib/bushido directory if it doesnt exist
        Dir.mkdir("#{Rails.root}/lib/bushido") if not Dir.exists? "#{Rails.root}/lib/bushido"
        
        lib "bushido/mail_routes.rb" do
          <<-EOF
::Bushido::Mailroute.map do |m|

  m.route("simple") do
    m.subject("hello")
  end

end
          EOF
        end

        lib("bushido/hooks/email_hooks.rb") do
          <<-EOF
class BushidoEmailHooks < Bushido::EventObserver

  def mail_simple
    puts "YAY!"
    puts params.inspect
  end

end
          EOF
        end
        
        initializer "bushido_hooks.rb" do
          <<-EOF
Dir["\#{Dir.pwd}/lib/bushido/**/*.rb"].each { |file| require file }
          EOF
        end
        
        initializer("bushido_mail_routes.rb", "require './lib/bushido/mail_routes.rb'")

      end
    end
  end
end
