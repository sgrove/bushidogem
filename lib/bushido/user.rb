module Bushido
  # Bushido User enables user validation against Bushido's server
  class User < Bushido::Base
    class << self
      
      # Checks whether user an email and password correspond to a valid bushido
      # user. Returns nil if false, or the Bushido user's ID if true.
      def valid?(email, pass)
        params = {}
        params[:email] = email
        params[:pass] = pass
        Bushido::Command.post_command(valid_unity_url, params)
      end

      # Checks whether email corresponds to a valid Bushido user.
      # Returns true or false
      def exists?(email)
        params = {}
        params[:email] = email
        Bushido::Command.post_command(exists_unity_url, params)
      end

      # send a Bushido invite with a short description of the app (also a box of chocolates, if he's a Kryptonian)
      # Bushido::User.invite("clark@kent-on-krypton.com")
      def invite(email)
        params = {}
        params[:email] = email
        Bushido::Command.post_command(invite_unity_url, params)
      end

      # List all pending invites
      # Bushido::User.pending_invites
      def pending_invites
        params = {}
        Bushido::Command.get_command(pending_invites_unity_url, params)
      end

      # To remove a user from an application
      # Bushido::User.remove("5z325f4knbm2f")
      def remove(ido_id)
          params = {}
          params[:ido_id] = ido_id
          Bushido::Command.post_command(remove_unity_url, params)
      end

      # To send a notification to a user who belongs to your app
      # Bushido::User.notify('5z325f4knbm2f', 'Example title', 'Example message', 'chat')
      def notify(ido_id, title, body, category="general")
        params            = {}
        params[:ido_id]   = ido_id
        params[:title]    = title
        params[:body]     = body
        params[:category] = category

        Bushido::Command.post_command(notify_user_url, params)
      end
    end
  end
end
