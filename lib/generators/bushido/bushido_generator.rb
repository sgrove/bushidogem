module Bushido
  module Generators
    class BushidoGenerator < Rails::Generators::NamedBase
      namespace "bushido"
      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a model with the given NAME (if one does not exist) with Bushido " <<
           "configuration plus a migration file and devise routes."

      hook_for :orm

    end
  end
end
