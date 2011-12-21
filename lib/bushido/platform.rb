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

      def protocol
        ENV['BUSHIDO_PROTOCOL'] || "https"
      end

      def port
        ENV['BUSHIDO_PORT']
      end

      def host
        bushido_port = port ? ":#{port}" : ""
        bushido_host = ENV['BUSHIDO_HOST'] || 'bushi.do'
        "#{protocol}://#{bushido_host}#{bushido_port}"
      end

      def on_bushido?
        ENV['HOSTING_PLATFORM']=="bushido"
      end

      def claimed?
        (ENV['BUSHIDO_CLAIMED'].nil? or ENV['BUSHIDO_CLAIMED'].blank?) ? false : true
      end

      def metrics_token
        ENV['BUSHIDO_METRICS_TOKEN']
      end

      def bushido_js_source
        "#{Bushido::Platform.host}/api/bushido.js"
      end
    end
  end
end
