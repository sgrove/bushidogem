module Bushido
  class DNS
    class << self
      def add_domain(name)
        Bushido::App.add_domain(Bushido::Platform.app, Bushido::Platform.key)
      end
    end
  end
end
