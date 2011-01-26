module Bushido
  class Utils
    class << self
      def while_authorized(&block)
        if Bushido::User.authentication_token.nil? or Bushido::User.email.nil?
          puts "Please authorized before attempting that command. You can run `bushido reauth` to update your credentials."
          exit 1
        else
          yield
        end
      end

      def home_directory
        ENV['HOME']
      end
    end
  end
end
