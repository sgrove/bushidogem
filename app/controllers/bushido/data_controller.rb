module Bushido
  class DataController < ApplicationController
    # PUT /bushido/data/
    def index
      @key = params.delete(:key)
      if ENV["BUSHIDO_KEY"] != @key
        respond_to do |format|
          format.html { render :layout => false, :text => true, :status => :forbidden }
          format.json { render :status => :unprocessable_entity }
          return
        end
        
        puts "OMG GOT DATA FROM BUSHIBUS"
        puts params.inspect
        Bushido::Data.fire(params)
        respond_to do |format|
          format.json {render :json =>{'acknowledged' : true} :status => 200}
        end
      end
    end
  end
end
