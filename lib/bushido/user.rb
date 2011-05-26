module Bushido
  class User
    class << self
      def connect_url
        "#{Bushido::Platform.host}/connect/v1"
      end
            
      def valid?(email, pass)
        params = {}
        params[:email] = email
        params[:pass] = pass
        Bushido::Command.post_command(connect_url+"/valid", params)
      end
      
      def exists?(email)
        params = {}
        params[:email] = email
        Bushido::Command.post_command(connect_url+"/exists", params)
      end

    end
  end
end
