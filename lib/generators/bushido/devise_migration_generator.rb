module Bushido
  module Generators
    class DeviseMigrationGenerator < Rails::Generators::NamedBase

      def create_devise_migration_file
        fields_to_add = []
        new_resource = class_name.constantize.new
        
        fields_to_add << "first_name" if not new_resource.respond_to?(:first_name)
        fields_to_add << "last_name"  if not new_resource.respond_to?(:last_name)
        fields_to_add << "email"      if not new_resource.respond_to?(:email)

        inject_into_class "app/models/#{class_name.underscore}.rb", class_name, "attr_accessor :ido_id\n"

        generate("migration", "AddBushidoFieldsTo#{class_name}", *fields_to_add.collect! { |field| field + ":string"})
      end
    end
  end
end

