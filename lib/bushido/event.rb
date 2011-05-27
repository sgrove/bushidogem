module Bushido
  # Bushido::Event lists all the events from the Bushido server. All events
  # are hashes with the following keys:
  # * category
  # * name
  # * data
  # Data will hold the arbitrary data for the type of event signalled
  class Event
    begin
      @@events = YAML.load(ENV["BUSHIDO_EVENTS"]) #:nodoc:
    rescue
      @@events = []
    end

    class << self
      # Lists all events
      def all
        @@events
      end

      # Lists the first (oldest) event
      def first
        @@events.first
      end

      # Lists the last (newest) event
      def last
        @@events.last
      end
    end
  end
end
