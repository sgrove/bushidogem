module Bushido
  class Data #:nodoc:
    
    extend Hooks

    class << self
      def attach(*models)
        # Total no-op, we just need to load the classes in order to
        # register the hooks, and this does that.
      end

      
      def publish(model, model_data)
        # POST to /apps/:id/bus
        data = {}
        data[:key] = Bushido::Platform.key

        data["data"]  = model_data
        data["data"]["ido_model"] = model
        #puts "Publishing Ido model"
        #puts data.to_json
        #puts Bushido::Platform.publish_url

        # TODO: Catch non-200 response code
        response = JSON.parse(RestClient.post(Bushido::Platform.publish_url, data.to_json, :content_type => :json, :accept => :json))
        if response['ido_id'].nil? or response['ido_version'].nil?
          return false
        end

        return response
      end
    end
  end
end
