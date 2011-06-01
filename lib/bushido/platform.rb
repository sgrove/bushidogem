module Bushido
  class Platform #:nodoc:
    class << self
      def name
        ENV['BUSHIDO_NAME']
      end


      def key
        ENV['BUSHIDO_APP_KEY']
      end


      def host
        "http://#{ENV['BUSHIDO_HOST'] || 'bushi.do'}"
      end
    end
  end
end
