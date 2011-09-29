module Bushido

  class Base
    class << self
      url_pairs = {
                    :unity=>[:valid, :exists, :invite, :pending_invites, :remove],
                    :email=>[:send]
                  }
      
      # NOTE Cannot use define_singleton_method since ruby 1.8 compatibility is a must
      url_pairs.each_pair do |prefix, method_names|
        method_names.each do |method_name|
          define_method "#{method_name}_#{prefix}_url".to_sym do
            "#{Bushido::Platform.host}/#{prefix}/#{Bushido::Config.api_version}/#{method_name}"
          end
        end
      end
    end
  end

end
