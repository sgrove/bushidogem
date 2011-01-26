module Bushido
  class App
    class << self
      def create(url)
        puts "Creating account for #{Bushido::User.email}..."

        post({:app => {:url => url}})
      end

      def list
        response = Bushido::Command.get_command("#{Temple}/apps")

        response.each do |app|
          puts app["app"]['subdomain']
        end
      end

      def get(name, params={})
        url = "#{Temple}/apps/#{name}"
        Bushido::Command.get_command(url, params)
      end

      def put(app, command)
        url = "#{Temple}/apps/#{app}.json"
        params = {:command => command}

        show_response Bushido::Command.put_command(url, params)
      end

      def post(params)
        url = "#{Temple}/apps"
        show_response Bushido::Command.post_command(url, params)
      end

      def show_response(response)
        show_messages response
        show_errors   response
      end

      def show_messages(response)
        if response["messages"]
          puts "Messages:"
          response["messages"].each_with_index do |error, counter|
            puts "\t#{counter + 1}. #{error}"
          end
        end
      end

      def show_errors(response)
        if response["errors"]
          puts "Errors:"
          response["errors"].each_with_index do |error, counter|
            puts "\t#{counter + 1}. #{error}"
          end
        end
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
    end
  end
end
