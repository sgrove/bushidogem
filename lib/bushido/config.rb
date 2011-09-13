module Bushido
  class Config

    # API version defaults to v1
    # Passing prefix "v" to ensure that developers assume it's a string. For future advantage when using API versions like 1.6.23
    @api_version = "v1"
    
    class << self
      attr_accessor :api_version
    end
  end
end
