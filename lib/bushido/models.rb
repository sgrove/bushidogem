module Bushido
  module Models
    def self.included(base)
      base.extend ClassMethods
    end

    def bushido_save
      # It's possible we're saving an item just handed to us by Bushido, so we
      # don't want to re-publish it. We can detect it using the version.
      
      puts "what"
      # bushido_id.nil? This is new, it's from us (otherwise bushido would have given it an id), we should publish it.
      # bushido_version == self.find(self.id).bushido_version The version hasn't changed, our data has, we should publish it
      puts "new_record? #{self.new_record?}"
      puts "self.id = #{self.id}"
      puts "ido_id.nil? #{ido_id.nil?}"
      puts "ido_version == self.class.find(self.id).ido_version ? #{ido_version == self.class.find(self.id).ido_version}" unless self.new_record?
      if self.ido_id.nil? or (not self.new_record? and self.ido_version == self.class.find(self.id).ido_version)
        puts "Local change, publishing to Bushido databus"

        data = self.to_bushido

        begin
          response = Bushido::Data.publish(self.class.class_variable_get("@@bushi_model"), data)
        rescue => e
          puts e.inspect
          # TODO: Catch specific exceptions and bubble up errors (e.g. 'bushido is down', 'model is malformed', etc.)
          return false
        end

        self.ido_version = response["ido_version"]
        self.ido_id ||= response["ido_id"]

        puts response.inspect
      else
        puts "Remote change, not publishing to Bushido databus"
      end

      return true
    end

    module ClassMethods
      def bushido model
        self.class_variable_set("@@bushi_model", model)

        [:create, :update, :destroy].each do |event|
          puts "Hooking into #{model}.#{event}..."

          Bushido::Data.listen("#{model}.#{event}") do |data, hook|
            puts "#{hook}.) Firing off #{model}.#{event} now with data: #{data}"
            self.send("on_bushido_#{event}".to_sym, self.from_bushido(data))
          end
        end
        
        before_save :bushido_save
      end
    end
  end
end
