module Bushido

  class Base
    class << self
      def method_missing(method, *args)
          if /.*_url/ =~ method
            method_strings = method.to_s.split "_"
            method_strings.pop
            path = {}
            path[:prefix] = method_strings.pop
            path[:method] = method_strings.join "_"
            api_url(path)
          else
            super
          end
      end

      def api_url(path)
        "#{path[:prefix]}/#{Bushido::Config.api_version}/#{path[:method]}"
      end
    end
  end

end
