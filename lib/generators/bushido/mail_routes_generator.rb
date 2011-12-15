module Bushido
  module Generators
    class MailRoutesGenerator < Rails::Generators::Base
  
      def create_mail_routes_file
        # Create the lib/bushido directory if it doesnt exist
        Dir.mkdir("#{Rails.root}/lib/bushido") if not Dir.exists? "#{Rails.root}/lib/bushido"
        
        # Create the mail routes file
        lib "bushido/mail_routes.rb" do
          <<-EOF
::Bushido::Mailroute.map do |m|

  m.route("mail.simple") do
    m.subject("hello")
  end

end
          EOF
        end
        
        # Create the initializer required to load the mail routes file
        initializer("bushido_mail_routes.rb", "require './lib/bushido/mail_routes.rb'")
      end

    end
  end
end
