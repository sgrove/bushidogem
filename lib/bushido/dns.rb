module Bushido
  class DNS
    class << self
      def add_domain(domain)
        Bushido::App.add_domain(Bushido::Platform.app, domain)
      end

      def remove_domain(domain)
        Bushido::App.add_domain(Bushido::Platform.app, domain)
      end
    end
  end
end
