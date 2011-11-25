module ActionMailer
  class Base
    private
    def perform_delivery_bushido(mail)
      if mail.to.nil?
        unless logger.nil?
          logger.error "This mail isn't addressed to anyone! Dropping"
        end

        return false
      end

      #result = Bushido::App.mail_allowed?
      result = true

      if result
        logger.info result.inspect unless logger.nil?
        if result["success"] == true
          Bushido::SMTP.setup_action_mailer_smtp!

          unless logger.nil?
            logger.info "App allowed to send email, sending via SMTP"
            __send__("perform_delivery_smtp", mail) if perform_deliveries
          end
        else
          logger.info "Unable to send email: #{result['message']}" unless logger.nil?
        end
      else
        logger.info "Unable to contact Bushido to verify email credentials" unless logger.nil?
      end
    end
  end
end
