module Bushido
  class User
    class << self
      def account
        load_config || {}
      end

      def load_config
        begin
          return JSON.parse(File.open(File.expand_path("~/.bushido/config.json"), 'r') { |l| l.read })
        rescue Errno::ENOENT
        end
      end

      def load_account
        begin
          @account = JSON.parse(File.open(File.expand_path("~/.bushido/config.json"), 'r') { |l| l.read })
        rescue Errno::ENOENT
          @account = retrieve_account
        end
      end

      def reauth
        retrieve_account
      end

      def update_account(account)
        print "Storing account information..."
        File.open(File.expand_path("~/.bushido/config.json"), 'w') { |f| f.write(account.to_json) }
        puts " Done!"
      end

      def retrieve_account
        credentials = self.prompt_for_credentials

        raw = RestClient.get "#{Bushido::Temple}/users/verify.json", {:params => {:email => credentials[:email], :password => credentials[:password]}, :accept => :json}

        begin
          result = JSON.parse(raw)
        rescue
          puts "Our servers didn't respond properly while trying to retrieve the account, this seems to be an issue on our end. Please email us at support@bushi.do to clear this up."
          exit 1
        end

        if result["authentication_token"] and result["error"].nil?
          update_account({:email => credentials[:email], :authentication_token => result["authentication_token"]})
          return {:email => credentials[:email], :authentication_token => result["authentication_token"]}
        else
          puts result["error"]
          if result["error_type"] == "verification_failure"
            puts ""
            print "If this is your first time using Bushido, would you like to create an account using the email and password you just entered?\n[y/n]"
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
        begin 
          raw = RestClient.get "#{Bushido::Temple}/users/create.json", {:params => {:email => credentials[:email], :password => credentials[:password], :accept => :json}}
        rescue RestClient::UnprocessableEntity
          puts "We ran into an error registering, either our site is down or that name is registered."
          exit 1
        end

        begin
          result = JSON.parse(raw)
          #puts result.inspect
          #puts "----------------------------------------------------------------------"
        rescue JSON::ParserError
          puts "Our servers didn't respond properly while trying to create an account, this seems to be an issue on our end. Please email us at support@bushi.do to clear this up."
          exit 1
        end

        if result["errors"]
          puts "There were some errors registering: "
          
          result["errors"].each_pair { |field, error| puts "  #{field.capitalize} #{error}" }
          exit 1
        end

        update_account result
        return credentials
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
