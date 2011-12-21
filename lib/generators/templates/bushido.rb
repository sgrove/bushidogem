Bushido.setup do |config|
  #We should abstract this way and intelligently pick the orm
  
  # ==> ORM configuration
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'bushido/orm/<%= options[:orm] %>'

end
