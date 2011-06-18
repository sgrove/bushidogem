require 'rails/generators/active_record'
require 'generators/bushido/orm_helpers'

module ActiveRecord
  module Generators
    class BushidoGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include Bushido::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def generate_model
        invoke "active_record:model", [name], :migration => false unless model_exists?
      end

      def copy_bushido_migration
        migration_template "migration.rb", "db/migrate/bushido_create_#{table_name}"
      end

      def inject_bushido_content
        inject_into_class model_path, class_name, model_contents + <<-CONTENT
  # Setup accessible (or protected) attributes for your model
  attr_accessible :bushido_id, :bushido_version
CONTENT
      end
    end
  end
end
