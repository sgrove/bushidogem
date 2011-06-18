module Bushido
  module Models
    
    @@bushi_model = :customer_lead
    # def bushido(*models)
    #   puts "bushido model method called"
    #   puts models.inspect
    #   models.each do |m|
    #     
    #     puts "setting up bushido hooks for"
    #     puts m
    #     puts m.inspect
    #     
    #     Bushido::Data.listen(m) do |data, hook|
    #       puts "this is code block for models"
    #       puts m.inspect
    #       puts data.inspect
    #       puts hook.inspect
    #       puts self.inspect
    #       self.update_attributes(data)
    #     end
    #     
    #     self.before_save do
    #       puts "Bushido before save publish called"
    #       return Bushido::Data.publish(m, self)
    #     end
    #     
    #   end
    # end
    
    def self.bushido model
      @@bushi_model = model
    end
    
    def to_bushido &block
      yield block
    end
    
    def from_bushido &block
      yield block
    end
    
    def on_bushido_update &block
      Bushido::Data.listen("#{@@bushi_model}.#{update}") do |data, hook|
        block.call(data, hook)
      end
    end
    
    def on_bushido_create
      Bushido::Data.listen("#{@@bushi_model}.#{create}") do |data, hook|
        block.call(data, hook)
      end
    end
    
    def on_bushido_destroy
      Bushido::Data.listen("#{@@bushi_model}.#{destroy}") do |data, hook|
        block.call(data, hook)
      end
    end
    
    def on_bushido_save
      Bushido::Data.publish(@@bushi_model, self.to_bushido)
    end
  end
end