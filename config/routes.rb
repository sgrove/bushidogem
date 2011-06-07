Rails.application.routes.draw do |map|

  mount_at = Bushido::Engine.config.mount_at

  match mount_at => 'bushido/#index'

  map.resources :envs, :only => [ :update, :show ],
                          :controller => "bushido/envs",
                          :path_prefix => mount_at,
                          :name_prefix => "bushido_"

end