module Bushido
  class Platform #:nodoc:
    class << self
      def app
        ENV['BUSHIDO_APP']
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
