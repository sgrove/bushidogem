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


      def set_subdomain(subdomain)
        put :set_subdomain, {:subdomain => subdomain}
      end


      def add_domain(domain)
        put :add_domain, {:domain => domain}
      end


      def remove_domain
        put :remove_domain
      end


      def clear_logs
        put :clear_logs
      end


      def logs
        get({:gift => "logs"})
      end


      def ssh_key
        get({:gift => "ssh_key"})["ssh_key"]
      end
    end
  end
end

