module Bushido
  class Data #:nodoc:
    
    extend Hooks
    
    class << self      
      def publish(model, data)
        data[:model] = model
        data[:key] = Bushido::Platform.key
        response = JSON.parse(RestClient.post(Bushido::Platform.publish_url, data.to_json, :content_type => :json, :accept => :json))
        if response['data_id'].nil? or response['data_version'].nil?
          return false
        end
      end
    end
    
  end
end