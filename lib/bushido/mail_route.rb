module Bushido
  class Mailroute
    def self.map(&block)
      raise StandardError.new("Mailroute only supported in Ruby >= 1.9.1") if RUBY_VERSION < "1.9.1"

      @@routes ||= self.new
      yield @@routes
    end

    def self.routes
      @@routes
    end

    def self.clear_routes!
      @@routes = self.new
    end

    # Taken from somewhere on stackoverflow, props to the author!
    def string_to_regex(string)
      return nil unless string.strip.match(/\A\/(.*)\/(.*)\Z/mx)
      regexp , flags = $1 , $2
      return nil if !regexp || flags =~ /[^xim]/m

      x = /x/.match(flags) && Regexp::EXTENDED
      i = /i/.match(flags) && Regexp::IGNORECASE
      m = /m/.match(flags) && Regexp::MULTILINE

      Regexp.new regexp , [x,i,m].inject(0){|a,f| f ? a+f : a }
    end

    def self.field_matcher(*field_names)
      self.class_eval do
        field_names.each do |field_name|
          define_method field_name do |line, options={:constraints => {}}|
            add_route_rule(field_name.to_s, build_matcher(line, options[:constraints]), options[:required])
          end
        end
      end
    end

    attr_accessor :params, :constraints, :routes, :current_target, :reply
    field_matcher :from, :sender, :subject, :body

    # Regex shortcuts
    def ampm
      /\d+[apmAPM]{2}/
    end

    def word
      /\w+/
    end

    def words_and_spaces
      /[\w|\s]+/
    end


    def initialize
      @routes ||= []
      @constraints = []
    end

    def match(target, &block)
      @routes << {target => []}
      @current_target = @current_target.nil? ? 0 : @current_target + 1
      yield self
    end

    # Maybe add_requirement is better?
    # Constraint procs must return true if the mail should be allowed
    def add_constraint(params_field_name, requirement_type)
      checkers = {
        :not_allowed => Proc.new { |params| puts params_field_name; puts params.inspect; params[params_field_name.to_s].nil? },
        :required    => Proc.new { |params| not params[params_field_name.to_s].nil? },
        :custom      => Proc.new { |params| requirement_type.call(params[params_field_name.to_s]) }
      }

      checker = requirement_type.is_a?(Proc) ? checkers[:custom] : checkers[requirement_type]

      raise StandardError if checker.nil?

      @constraints << checker
      @constraints.flatten! # In case we've added a nil
    end

    def process(mail)
      @params = preprocess_mail(mail)

      # Iterate through the routes and test each rule for each route against current mail
      @routes.each do |route|
        _matches = true
        
        # route: {'name-of-route' => [[:field, matcher]]}
        route_name = route.keys.first

        route[route_name].each do |matcher|
          result = string_to_regex(matcher[1]).match(mail[matcher.first])
          if result.nil?
            _matches = false
            break
          end

          # Only Ruby 1.9 support named capture groups
          result.names.each { |key| @params[key] = result[key] }
        end
        
        # Run param-based constraints
        if _matches and @constraints.select{ |proc| proc.call(@params) != true }.empty?
          params['mail'] = mail
          Bushido::Data.fire(params, route_name)
          break
        end
      end
    end

    private

    def preprocess_mail(mail)
      params = {}
      # Remove Re:'s from the subject and set reply => true if present
      if mail["subject"].match(/^(Re: ){1,}/i)
        params['reply'] = true
        until !mail["subject"].match(/^(Re: ){1,}/i)
          mail["subject"] = mail["subject"][4..-1]
        end
      end

      if from_details = mail['from'].match(/^([\w|\s]*) <(.*)>/)
        params['from_name']  = from_details[1]
        params['from_email'] = from_details[2]
      end

      return params
    end

    def add_route_rule(field, matcher, required=true)
      route = @routes[@current_target]
      route[route.keys.first] << [field, matcher, required]
    end

    def build_matcher(line, constraints)
      temp = "/#{line}/"
      constraints.keys.each { |key| temp.gsub!(":#{key}", "(?<#{key}>#{constraints[key].inspect[1..-2]})")  }
      temp
    end
  end
end

