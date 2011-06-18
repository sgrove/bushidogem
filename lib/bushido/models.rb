module Bushido
  module Models
    # def initalize
    #   puts "omg model initalize!!!"
    # end
    def bushido(*models)
      puts "bushido model method called"
      puts models.inspect
      models.each do |m|
        
        puts "setting up bushido hooks for"
        puts m
        puts m.inspect
        
        Bushido::Data.listen(m) do |data, hook|
          puts "this is code block for models"
          puts m.inspect
          puts data.inspect
          puts hook.inspect
          puts self.inspect
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