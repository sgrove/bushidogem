module Bushido
  # Bushido::Bar
  class Bar
    # Default to showing the bar on all paths
    @@bar_paths = [/.*/]

    def set_bar_display_paths(*paths)
      @@bar_paths = paths
    end

    def self.in_bar_display_path?(env)
      @@bar_paths.each do |path_regex|
        return true if env['PATH_INFO'] =~ path_regex
      end

      return false
    end
  end
end
