require 'orm_adapter/adapters/mongoid'

module Bushido
  module Orm
    module Mongoid
      module Hook
        def bushido_modules_hook!
          extend Schema
          yield
          return unless Devise.apply_schema
          devise_modules.each { |m| send(m) if respond_to?(m, true) }
        end
      end

      module Schema
        include Bushido::Schema

        # Tell how to apply schema methods
        def apply_bushido_schema(name, type, options={})
          type = Time if type == DateTime
          field name, { :type => type }.merge!(options)
        end
      end
    end
  end
end

Mongoid::Document::ClassMethods.class_eval do
  include Bushido::Models
  include Bushido::Orm::Mongoid::Hook
end