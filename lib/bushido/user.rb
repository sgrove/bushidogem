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

      # Use this to invite a user to an application on Bushido.
      # Bushido::User.invite("jake@navi-on-pandora.com")
      def invite(email)
        if exists?
            # TODO add an invite to the db and send an email if the user has email notifications enabled
        else
            # TODO send a Bushido invite email with short description of the app and also a box of chocolates
        end
      end

      # List all pending invites
      # Bushido::User.pending_invites
      def pending_invites
          # TODO returns a list of pending invites (email addresses)
      end
    end
  end
end
