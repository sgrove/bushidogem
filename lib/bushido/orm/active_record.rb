require 'orm_adapter/adapters/active_record'

module Bushido
  module Orm
    # This module contains some helpers and handle schema (migrations):
    #
    #   create_table :accounts do |t|
    #     t.database_authenticatable
    #     t.confirmable
    #     t.recoverable
    #     t.rememberable
    #     t.trackable
    #     t.lockable
    #     t.timestamps
    #   end
    #
    # However this method does not add indexes. If you need them, here is the declaration:
    #
    #   add_index "accounts", ["email"],                :name => "email",                :unique => true
    #   add_index "accounts", ["confirmation_token"],   :name => "confirmation_token",   :unique => true
    #   add_index "accounts", ["reset_password_token"], :name => "reset_password_token", :unique => true
    #
    module ActiveRecord
      module Schema
        include Bushido::Schema

        # Tell how to apply schema methods.
        def apply_bushido_schema(name, type, options={})
          column name, type.to_s.downcase.to_sym, options
        end
      end
    end
  end
end

# module ActiveRecord
#   class Base
#    puts "active record instance eval"
#    extend Bushido::Models
#  end
# end
ActiveRecord::Base.send :include, Bushido::Models
ActiveRecord::ConnectionAdapters::Table.send :include, Bushido::Orm::ActiveRecord::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Bushido::Orm::ActiveRecord::Schema