module Bushido
  class EventObserver
    attr_accessor :params

    def self.inherited(klass)
      if Bushido::Platform.on_bushido?
        Bushido::Data.add_observer(klass.new)
      else
      end
    end

    def initialize
      @params ||= {}
    end

    def params
      @params
    end
  end
end
