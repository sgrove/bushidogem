module Bushido
  module Models
    def bushido(*models)
      models.each do |m|
        
        Bushido::Data.listen(m) do |data, hook| 
          self.update_attributes(data)
        end
        
        self.before_save do
          return Bushdido::Data.publish(m, self)
        end
        
      end 
       
    end
  end
end