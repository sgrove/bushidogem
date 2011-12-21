require 'generators/bushido/orm_helpers'

module Mongoid
  module Generators
    class bushidoGenerator < Rails::Generators::NamedBase
      include bushido::Generators::OrmHelpers

      def generate_model
        invoke "mongoid:model", [name] unless model_exists?
      end

      def inject_bushido_content
        inject_into_file model_path, model_contents, :after => "include Mongoid::Document\n"
      end
    end
  end
end