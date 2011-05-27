module Bushido
  # Bushido User enables user validation against Bushido's server
  class User
    class << self
      def unity_url #:nodoc:
        "#{Bushido::Platform.host}/connect/v1"
      end


      # Checkswhether user an email and password correspond to a valid bushido
      # user. Returns nil if false, or the Bushido user's ID if true.
      def valid?(email, pass)
        params = {}
        params[:email] = email
        params[:pass] = pass
        Bushido::Command.post_command("#{unity_url}/valid", params)
      end
      

      # Checks whether email corresponds to a valid Bushido user.
      # Returns true or false
      def exists?(email)
        params = {}
        params[:email] = email
        Bushido::Command.post_command("#{unity_url}/exists", params)
      end
    end
  end
end
