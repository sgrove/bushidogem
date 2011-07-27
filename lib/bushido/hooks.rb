module Hooks
  @@hooks = {}
  
  def fire(data, *events)
    #puts "Hooks: #{@@hooks.inspect}"
    #puts "Events: #{events.inspect}"
    #puts "\twith data: #{data.inspect}"
    unless @@hooks[:global].nil?
      @@hooks[:global].call(data, 'global')
    end
    
    if events.length > 0
      events.each do |event|
        #print "Checking for event: #{event} in hooks..."
        if @@hooks[event].nil?
          #puts "not found, ignoring."
        else
          #puts "found, firing!"
          @@hooks[event].call(data, event)
        end
      end
    end
  end
  
  def listen *events, &block
    #puts "Listening for #{events.inspect}"

    if events.empty? and block_given?
      @@hooks[:global] = block
    elsif !events.nil? and block_given?
      events.each do |event|
        @@hooks[event] = block
      end
    end
  end
end
