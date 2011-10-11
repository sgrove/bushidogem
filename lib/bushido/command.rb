module Bushido
  class Command #:nodoc:
    @@last_request  = nil
    @@request_count = 0
    @@last_request_successful = true

    class << self
      def request_count
        @@request_count
      end

      def get_command(url, params={})
        @@request_count += 1
        params.merge!({"auth_token" => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

        begin
          raw = RestClient.get(url, {:params => params, :accept => :json})
        rescue # => e
          # puts e.inspect
          @@last_request_successful = false
          return nil
        end

        @@last_request_successful = true
        @@last_request = JSON.parse raw
      end

      def post_command(url, params)
        @@request_count += 1
        params.merge!({"auth_token" => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

        begin
          raw = RestClient.post(url, params.to_json, :content_type => :json, :accept => :json)
        rescue # => e
          # puts e.inspect
          @@last_request_successful = false
          return nil
        end

        @@last_request_successful = true
        @@last_request = JSON.parse raw    
      end

      def put_command(url, params, meta={})
        @@request_count += 1
        
        if meta[:force]
          params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

          begin
            raw = RestClient.put(url, params.to_json,  :content_type => :json)
          rescue # => e
            # puts e.inspect
            @@last_request_successful = false
            return nil
          end

        else
          params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?

          begin
            raw = RestClient.put(url, params.to_json,  :content_type => :json)
          rescue # => e
            #puts e.inspect
            @@last_request_successful = false
            return nil
          end
        end
        
        @@last_request_successful = true
        @@last_request = JSON.parse raw
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

      def last_command_successful?
        @@last_request_successful
      end

      def last_command_errored?
        not last_command_successful?
      end
    end
  end
end
