module Bushido
  class Command
    class << self
      def get_command(url, params={})
        params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

        raw = RestClient.get(url, {:params => params, :accept => :json})
        response = JSON.parse raw    
      end

      def post_command(url, params)
        params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

        raw = RestClient.post(url, params.to_json, :content_type => :json, :accept => :json)
        response = JSON.parse raw    
      end

      def put_command(url, params, meta={})
        if meta[:force]
          params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

          raw = RestClient.put(url, params.to_json,  :content_type => :json)
          response = JSON.parse raw

        else
          Bushido::Utils.while_authorized do
            params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

            raw = RestClient.put(url, params.to_json,  :content_type => :json)
            response = JSON.parse raw
          end
        end
      end

      def show_response(response)
        show_messages response
        show_errors   response
      end

      def show_messages(response)
        if response["messages"]
          puts "Messages:"
          response["messages"].each_with_index do |error, counter|
            puts "\t#{counter + 1}. #{error}"
          end
        end
      end

      def show_errors(response)
        if response["errors"]
          puts "Errors:"
          response["errors"].each_with_index do |error, counter|
            puts "\t#{counter + 1}. #{error}"
          end
        end
      end
    end
  end
end
