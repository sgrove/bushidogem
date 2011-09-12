module Bushido
  class Config
    
    @api_version = "v1"
    
    class << self
      attr_accessor :api_version
    end
  end
end
