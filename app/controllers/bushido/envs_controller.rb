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

        var = params[:id].upcase

        ENV[var] = params[:value]
        @value = ENV[var]
        
        respond_to do |format|
          if @value != ENV[var]
            format.html{render :layout => false, :text => true, :status => :unprocessable_entity}
            format.json{render :status => :unprocessable_entity}
          else
            Bushido::Data.fire(var, {var => ENV[var]})
            format.html{render :text => true}
            format.json{render :json => {var => ENV[var]}}
          end
        end
      end
    end
  end
end
