#require 'rack/utils'

module Bushido
  class Middleware
    include Rack::Utils

    def initialize(app, opts = {})
      @app = app
    end

    def call(env)
      if Bushido::Platform.on_bushido? and Bushido::Bar.in_bar_display_path?(env)
        status, headers, response = @app.call(env)

        content = ""
        response.each { |part| content += part }

        # "claiming" bar + stats ?
        content.gsub!(/<\/body>/i, <<-STR
            <script type="text/javascript">
              var _bushido_app = '#{Bushido::Platform.name}';
              var _bushido_claimed = #{Bushido::Platform.claimed?.to_s};
              var _bushido_metrics_token = '#{Bushido::Platform.metrics_token}';
              (function() {
                var bushido = document.createElement('script'); bushido.type = 'text/javascript'; bushido.async = true;
                bushido.src = '#{Bushido::Platform.bushido_js_source}?t=#{::Bushido::VERSION.gsub('.', '')}';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(bushido, s);
              })();
            </script>     
          </body>
        STR
        )

        headers['content-length'] = bytesize(content).to_s
        [status, headers, [content]]
      else
        @app.call(env)
      end
    end
  end
end

