module Bushido
  class Platform
    class << self
      def app
        ENV['BUSHIDO_DOMAIN']
      end

      def key
        ENV['BUSHIDO_APP_KEY']
      end
    end
  end
end
