module Bushido
  class App
    class << self
      def create(url)
        Bushido::User.load_account

        puts "Creating from #{url} for #{Bushido::User.email}..."

        post({:app => {:url => url}})
      end

      def list
        response = Bushido::Command.get_command("#{Temple}/apps")

        response.each do |app|
          puts app["app"]['subdomain']
        end
      end

      def open(name)
        location = "http://#{name}.#{Bushido::Temple.gsub('http://','')}"
        puts "Opening \"#{location}\" ..."
        exec "open #{location}"
      end

      def get(name, params={})
        url = "#{Temple}/apps/#{name}"
        Bushido::Command.get_command(url, params)
      end

      def put(app, command, params={})
        url = "#{Temple}/apps/#{app}.json"
        params[:command] = command

        Bushido::Command.show_response Bushido::Command.put_command(url, params)
      end

      def post(params)
        url = "#{Temple}/apps"
        Bushido::Command.show_response Bushido::Command.post_command(url, params)
      end

      def show(name)
        result = get name
        puts result.inspect
      end

      def start(name)
        put name, :start
      end

      def stop(name)
        put name, :stop
      end

      def restart(name)
        put name, :restart
      end

      def claim(name)
        put name, :claim
      end

      def update(name)
        put name, :update
      end

      def add_var(name, key, value)
        puts put(name, :add_var, {:key => key, :value => value})
      end

      def remove_var(name, key)
        puts put(name, :remove_var, {:key => key})
      end

      def add_domain(name, domain)
        puts put(name, :add_domain, {:domain => domain})
      end

      def remove_domain(name)
        puts put(name, :remove_domain)
      end

      def clear_logs(name)
        puts put(name, :clear_logs)
      end

      def logs(name)
        puts get(name, {:gift => "logs"})
      end

      def ssh_key(name)
        puts get(name, {:gift => "ssh_key"})["ssh_key"]
      end
    end
  end
end
