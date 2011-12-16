module Bushido
  module Generators
    class AuthMigrationGenerator < Rails::Generators::NamedBase

      def create_auth_migration_file
        fields_to_add = []
        new_resource = class_name.constantize.new

        fields_to_add << "ido_id"     if not new_resource.respond_to?(:ido_id)
        fields_to_add << "first_name" if not new_resource.respond_to?(:first_name)
        fields_to_add << "last_name"  if not new_resource.respond_to?(:last_name)
        fields_to_add << "email"      if not new_resource.respond_to?(:email)
        fields_to_add << "locale"     if not new_resource.respond_to?(:locale)
        fields_to_add << "timezone"   if not new_resource.respond_to?(:timezone)
        
        inject_into_class "app/models/#{class_name.underscore}.rb", class_name do
<<-EOF
  attr_accessor :ido_id\n

  def bushido_extra_attributes(extra_attributes)
    self.first_name = extra_attributes["first_name"].to_s
    self.last_name  = extra_attributes["last_name"].to_s
    self.email      = extra_attributes["email"]
    self.locale     = extra_attributes["locale"]
  end
EOF
        end

        generate("migration", "AddBushidoFieldsTo#{class_name}", *fields_to_add.collect! { |field| field + ":string"})
        generate("migration", "AddIndexForIdoIdTo#{class_name}")
        Dir["db/migrate/*add_index_for_ido_id_to*"].each do |file|
          inject_into_file file, :after => "class AddIndexForIdoIdToUser < ActiveRecord::Migration\n  def change\n" do
            "    add_index :#{plural_name}, :ido_id\n"
          end
        end
      end

    end
  end
end

