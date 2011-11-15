module Bushido
  class SMTP
    class << self
      [:tls, :server, :port, :domain, :authentication, :user, :password].each do |method_name|
        define_method "#{method_name}".to_sym do
          ENV["SMTP_#{method_name.to_s.upcase}"]
        end
      end

      def setup_action_mailer_smtp!
        ActionMailer::Base.smtp_settings = {
          :enable_starttls_auto => Bushido::SMTP.tls,
          :tls =>                  Bushido::SMTP.tls,
          :address =>              Bushido::SMTP.server,
          :port =>                 Bushido::SMTP.port,
          :domain =>               Bushido::SMTP.domain,
          :authentication =>       Bushido::SMTP.authentication,
          :user_name =>            Bushido::SMTP.user,
          :password =>             Bushido::SMTP.password,
        }
      end
    end
  end
end
