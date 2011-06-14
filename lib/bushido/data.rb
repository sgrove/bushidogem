module Bushido
  class Data #:nodoc:
    
    extend Hooks
    
    class << self      
      def publish(model, data)
        data[:model] = model
        data[:key] = Bushido::Platform.key
        # POST /apps/:id/bus
        puts "bushido publishing model"
        puts data.to_json
        puts Bushido::Platform.publish_url
        RestClient.post(Bushido::Platform.publish_url, data.to_json, :content_type => :json, :accept => :json)
      end
    end
    
  end
end