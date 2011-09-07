module Bushido
  # Bushido User enables user validation against Bushido's server
  class User
    class << self
      def unity_url #:nodoc:
        "#{Bushido::Platform.host}/unity/v1"
      end

      # Checks whether user an email and password correspond to a valid bushido
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

      # send a Bushido invite with a short description of the app (also a box of chocolates, if he's a Kryptonian)
      # Bushido::User.invite("clark@kent-on-krypton.com")
      def invite(email)
        params = {}
        params[:email] = email
        Bushido::Command.post_command("#{unity_url}/invite", params)
      end

      # List all pending invites
      # Bushido::User.pending_invites
      def pending_invites
        params = {}
        Bushido::Command.get_command("#{unity_url}/pending_invites", params)
      end

      # To remove a user from an application
      # Bushido::User.remove("5z325f4knbm2f")
      def remove(ido_id)
          params = {}
          params[:ido_id] = ido_id
          Bushido::Command.post_command("#{unity_url}/remove", params)
      end

    end
  end
end
