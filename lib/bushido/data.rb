module Bushido
  class Data #:nodoc:
    @@observers = []

    def self.add_observer(observer)
      puts "Subscribing #{observer} to Bushido data calls"
      @@observers << observers
    end
    
    def self.fire(data, event)
      puts "Bushido Hooks Firing #{event} with => #{data.inspect}"
      @@observers.each do |observer|
        puts "#{observer}.respond_to?(#{event}) => #{observer.respond_to?(event)}"
        if observer.respond_to?(event)
          # Make a copy of the data so it's not mutated as the events
          # pass through the observers
          observer.instance_variable_set("@params", data.dup)
          observer.send(event)
        end
      end
    end
  end
end
