module Hooks

  @@hooks = {}
  
    def fire(data, *hooks)
      unless @@hooks[:global].nil?
        @@hooks[:global].call(data, 'global')
      end
      
      if hooks.length > 0
        hooks.each do |h|          
          unless @@hooks[h].nil? 
            @@hooks[h].call(data, hook)
          end
        end
      end
    end
    
    def listen *hooks, &block
      if hooks.empty? and block_given?
        @@hooks[:global] = block
      elsif !hooks.nil? and block_given?
        hooks.each do |h|
          @@hooks[h] = block
        end
      end
    end
        
end