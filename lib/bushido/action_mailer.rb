module ActionMailer
  class Base
    private
      def perform_delivery_bushido(mail)
        Bushido::Command.post_command(Bushido::Base.send_email_url, mail)
      end
  end
end
