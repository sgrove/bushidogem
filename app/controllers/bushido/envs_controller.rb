module Bushido
  class EnvsController < ApplicationController
    # PUT /bushido/envs/:id
    def update
      if ENV["BUSHIDO_APP_KEY"] != params[:key] or params[:id] == "BUSHIDO_KEY"
        respond_to do |format|
          format.html { render :layout => false, :text => true, :status => :forbidden }
          format.json { render :status => :unprocessable_entity }
        end

      else

        ENV[params[:id]] = params[:value]
        @value = ENV[params[:id]]
        
        respond_to do |format|
          if @value != ENV[params[:id]]
            format.html{render :layout => false, :text => true, :status => :unprocessable_entity}
            format.json{render :status => :unprocessable_entity}
          else
            Bushido::Data.fire(params[:id], {params[:id] => ENV[params[:id]]})
            format.html{render :text => true}
            format.json{render :json => {params[:id] => ENV[params[:id]]}}
          end
        end
      end
    end
  end
end
