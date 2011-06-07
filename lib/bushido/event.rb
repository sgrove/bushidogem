module Bushido
  # Bushido::Event lists all the events from the Bushido server. All events
  # are hashes with the following keys:
  # * category
  # * name
  # * data
  # Data will hold the arbitrary data for the type of event signalled
  class Event
    begin
      @@events = JSON.parse(ENV["BUSHIDO_EVENTS"]) #:nodoc:
    rescue
      @@events = []
    end

    attr_reader :category, :name, :data

    class << self
      # Lists all events
      def all
        @@events.collect{ |e| Event.new(e) }
      end

      # Lists the first (oldest) event
      def first
        Event.new(@@events.first)
      end

      # Lists the last (newest) event
      def last
        Event.new(@@events.last)
      end
    end

    def initialize(options={})
      @category = options["category"]
      @name = options["name"]
      @data = options["data"]
    end
  end
end
