module Bushido
  class User
    class << self
      def account
        load_config || {}
      end

      def clear_config
        print "Clearing out all local bushido configuration..."
        FileUtils.rm_rf "#{Bushido::Utils.home_directory}/.bushido/"
        puts "done"
      end

      def load_config
        begin
          return JSON.parse(File.open(File.expand_path("#{Bushido::Utils.home_directory}/.bushido/config.json"), 'r') { |l| l.read })
        rescue Errno::ENOENT
        end
      end

      def load_account
        begin
          @account = JSON.parse(File.open(File.expand_path("#{Bushido::Utils.home_directory}/.bushido/config.json"), 'r') { |l| l.read })
        rescue Errno::ENOENT
          @account = retrieve_account("Couldn't find your Bushido config on this machine.")
        end
      end

      def reauth
        retrieve_account("Re-authenticating your account.")
      end

      def update_account(account)
        print "Storing account information..."
        Dir.mkdir "#{Bushido::Utils.home_directory}/.bushido" unless (File.exist?("#{Bushido::Utils.home_directory}/.bushido") and File.directory?("#{Bushido::Utils.home_directory}/.bushido"))
        File.open(File.expand_path("#{Bushido::Utils.home_directory}/.bushido/config.json"), 'w') { |f| f.write(account.to_json) }
        puts " Done!"
      end

      def retrieve_account(msg)
        puts "#{msg} Enter your username and password, and we'll either retrieve if from your existing account on our servers, or create a new account for you."
        credentials = self.prompt_for_credentials
        puts "Please wait while we look up the account information..."

        result = Bushido::Command.put_command "#{Bushido::Temple}/users/verify", {:email => credentials[:email], :password => credentials[:password]}, {:force => true}

        if result["authentication_token"] and result["error"].nil?
          update_account({:email => credentials[:email], :authentication_token => result["authentication_token"]})
          return {:email => credentials[:email], :authentication_token => result["authentication_token"]}
        else
          puts result["error"]
          if result["error_type"] == "verification_failure"
            puts ""
            print "If this is your first time using Bushido, would you like to create an account using the email and password you just entered?\n[y/n] "
            if $stdin.gets.chomp == "y"
              self.create_account(credentials)
            else
              exit 1
            end
          end
        end
      end

      def create_account(credentials)
        # GET instead of POST because of AuthenticityToken issues. Deal with it later.
        result = Bushido::Command.post_command "#{Bushido::Temple}/users/create.json", {:email => credentials[:email], :password => credentials[:password]}

        Bushido::Command.show_response result

        if result["errors"].nil?
          update_account result
          return credentials
        else
          exit 1
        end
      end

      def show_api_key
        puts "#{account['authentication_token']}"
      end

      def authentication_token
        account["authentication_token"]
      end

      def email
        account["email"]
      end

      def prompt_for_credentials(confirm=false)
        result = {
          :email => self.prompt_for_email,
          :password => self.prompt_for_password
        }

        result.merge!({:password_confirmation => self.prompt_for_password(" Confirm: ")}) if confirm

        return result
      end

      def prompt_for_email
        print " Email: "
        email = $stdin.gets.chomp
      end

      def prompt_for_password(prompt=" Password:")
        ask(prompt) { |q| q.echo = false }
      end
    end
  end
end
