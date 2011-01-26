module Bushido
  class Command
    class << self
      def get_command(url, params={})
        params.merge!({:auth_token => Bushido::User.authentication_token}) if params[:auth_token].nil? unless Bushido::User.authentication_token.nil?

        raw = RestClient.get(url, {:params => params, :accept => :json})
        response = JSON.parse raw    
      end

      def post_command(url, params)
        params.merge!({:auth_token => Bushido::User.authentication_token}) if params[:auth_token].nil? unless Bushido::User.authentication_token.nil?

        raw = RestClient.post(url, params.to_json, :content_type => :json, :accept => :json)
        response = JSON.parse raw    
      end

      def put_command(url, params)
        Bushido::Utils.while_authorized do
          params.merge!({:auth_token => Bushido::User.authentication_token}) if params[:auth_token].nil? unless Bushido::User.authentication_token.nil?

          raw = RestClient.put(url, params.to_json,  :content_type => :json)
          response = JSON.parse raw
        end
      end
    end
  end
end
