module Bushido
  class DataController < ApplicationController
    # PUT /bushido/data/
    def index
      if ENV["BUSHIDO_KEY"] != params[:key] or params[:id] == "BUSHIDO_KEY"
        respond_to do |format|
          format.html { render :layout => false, :text => true, :status => :forbidden }
          format.json { render :status => :unprocessable_entity }
          return
        end
        
        puts "OMG GOT DATA FROM BUSHIBUS"
        puts params.inspect
        Bushido::Data.fire()
      end
    end
  end
end
