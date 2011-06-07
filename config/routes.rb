Rails.application.routes.draw do |map|

  map.resources :envs, :only => [ :update, :show ],
                          :controller => "bushido/envs",
                          :path_prefix => "/bushido",
                          :name_prefix => "bushido_"

end