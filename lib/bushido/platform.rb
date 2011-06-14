module Bushido
  class Platform #:nodoc:
    class << self
      def name
        ENV['BUSHIDO_NAME']
      end


      def key
        ENV['BUSHIDO_APP_KEY']
      end
      
      def publish_url
        "#{host}/apps/#{name}/bus"
      end


      def host
        port = ENV['BUSHIDO_PORT'] ? ":#{ENV['BUSHIDO_PORT']}" : ""
        "http://#{ENV['BUSHIDO_HOST'] || 'bushi.do'}#{port}"
      end
    end
  end
end
