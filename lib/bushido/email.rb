module Bushido
  # Bushido Emal enables sending email
  class Email
    class << self
      def email_url #:nodoc:
        "#{Bushido::Platform.host}/email/v1"
      end

      # Send email by passing email address.
      # Bushido::Email.send("user@example.com")
      def send(email_params)
        Bushido::Command.post_command("#{email_url}/send", email_params)
      end
    end
  end
end
