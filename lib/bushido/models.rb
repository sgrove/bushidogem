module Bushido
  module Models
    def bushido(*models)
      puts "bushido model method called"
      puts models.inspect
      models.each do |m|
        
        puts "setting up bushido hooks for"
        puts m
        puts m.inspect
        
        Bushido::Data.listen(m) do |data, hook| 
          
          self.update_attributes(data)
        end
        
        self.before_save do
          puts "Bushido before save publish called"
          return Bushido::Data.publish(m, self)
        end
        
      end 
       
    end
  end
end