module Bushido
  module Models
    def bushido(*models)
      models.each do |m|
        Bushido::Data.listen(m) do 
          self.update_attributes({m})
        end
      end  
    end
  end
end