module Bushido
  class Data #:nodoc:
    
    extend Hooks

    class << self      
      # POST /apps/:id/bus
      def publish(model, model_data)
        data = {}
        data[:key] = Bushido::Platform.key

        data["data"]  = model_data
        data["data"]["bushido_model"] = model
        puts "Publishing bushido model"
        puts data.to_json
        puts Bushido::Platform.publish_url

        # TODO: Catch non-200 response code
        response = JSON.parse(RestClient.post(Bushido::Platform.publish_url, data.to_json, :content_type => :json, :accept => :json))
        if response['data_id'].nil? or response['data_version'].nil?
          return false
        end

        return response
      end
    end
  end
end
