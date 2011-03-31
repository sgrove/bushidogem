module Bushido
  class App
    class << self
      def app_url
        "#{Bushido::Platform.host}/apps/#{Bushido::Platform.app}.json"
      end


      def get(params={})
        Bushido::Command.get_command(app_url, params)
      end


      def put(command, params={})
        params[:command] = command

        Bushido::Command.put_command(app_url, params)
      end


      def show
        result = get
      end


      def start
        put :start
      end


      def stop
        put :stop
      end


      def restart
        put :restart
      end


      def claim
        put :claim
      end


      def update
        put :update
      end


      def add_var(key, value)
        put :add_var, {:key => key, :value => value}
      end


      def remove_var(key)
        put :remove_var, {:key => key}
      end


      def domains
        get()["app"]["domains"]
      end


      def subdomain
        get()["app"]["subdomain"]
      end


      def subdomain_available?(subdomain)
        begin
          return put :subdomain_available?, {:subdomain => subdomain}
        rescue RestClient::UnprocessableEntity
          return false
        end
      end


      def set_subdomain(subdomain)
        result = put :set_subdomain!, {:subdomain => subdomain}
        if Bushido::Command.last_command_successful?
          ENV["BUSHIDO_SUBDOMAIN"] = subdomain
          ENV["PUBLIC_URL"] = "http://#{subdomain}.#{ENV['APP_TLD']}/"
          return result
        end

        result
      end


      def add_domain(domain)
        put :add_domain!, {:domain => domain}
      end


      def remove_domain(domain)
        put :remove_domain!, {:domain => domain}
      end


      def clear_log!(name)
        put :clear_log!, {:name => name}
      end


      # TODO: Update to use the new logs controller
      def logs
        get({:gift => "logs"})
      end


      def ssh_key
        get({:gift => "ssh_key"})["ssh_key"]
      end
    end
  end
end
