#require 'rack/utils'

module Bushido
  class Middleware

    BUSHIDO_JS_URL = "#{Bushido::Platform.host}/api/bushido.js"

    include Rack::Utils

    def initialize(app, opts = {})
      @app = app
      @bushido_app_name       = ENV['BUSHIDO_APP']
      @bushido_metrics_token  = ENV['BUSHIDO_METRICS_TOKEN']
      @bushido_claimed        = (ENV['BUSHIDO_CLAIMED'].nil? or ENV['BUSHIDO_CLAIMED'].blank?) ? false : true
    end

    def call(env)
      @bushido_invitation_token = (Rack::Request.new(env).params[:invitation_token].nil? ) ? '' : Rack::Request.new(env).params[:invitation_token]
      @bushido_claimed        = (ENV['BUSHIDO_CLAIMED'].nil? or ENV['BUSHIDO_CLAIMED'].blank?) ? false : true

      status, headers, response = @app.call(env)
      
      unless @bushido_app_name.empty?
        content = ""
        response.each { |part| content += part }

        # "claiming" bar + stats ?
        content.gsub!(/<\/body>/i, <<-STR
            <script type="text/javascript">
              var _bushido_app = '#{@bushido_app_name}';
              var _bushido_claimed = #{@bushido_claimed.to_s};
              var _bushido_invitation_token = '#{@bushido_invitation_token}';
              var _bushido_metrics_token = '#{@bushido_metrics_token}';
              (function() {
                var bushido = document.createElement('script'); bushido.type = 'text/javascript'; bushido.async = true;
                bushido.src = '#{BUSHIDO_JS_URL}?#{::Bushido::VERSION.gsub('.', '')}';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(bushido, s);
              })();
            </script>     
          </body>
        STR
        )

        headers['content-length'] = bytesize(content).to_s
      end
      [status, headers, [content]]
    end

  end
end

